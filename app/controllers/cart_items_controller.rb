class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user_cart_items, only: [:index, :create]
  before_action :set_cart_item, only: [:update, :destroy]
  before_action :set_cart_item_detail, only: [:index, :check_out, :review_and_payment]

  def create
    @cart_item = current_user.cart_items.find_or_initialize_by(cart_item_params)
    @product = @cart_item.product
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_items_path, notice: 'Item was successfully added.' }
        format.json { render :show, status: :created, location: @cart_item }
        format.js
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:increase].present? && @cart_item.product.quantity > 0
      @cart_item.quantity+= 1
    elsif params[:decrease].present? && @cart_item.quantity > 1
      @cart_item.quantity-= 1
    elsif params[:cart_item][:quantity].to_i > 0
      @cart_item.quantity = params[:cart_item][:quantity]
    end
    @cart_item.save
    set_cart_item_detail

    respond_to do |format|
      if @cart_item.update(cart_update_params)
        format.html { redirect_to cart_items_path, notice: 'Cart item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart_items = current_user.cart_items.all
    @cart_item.destroy
    set_cart_item_detail

    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully removed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def check_out
    @address= Address.new
  end

  def review_and_payment
    @cart_items = current_user.cart_items
    if @cart_items.present? 
      @order= current_user.orders.new
    else
      redirect_to root_url 
    end
  end

  def apply_coupon
    if params[:code].present?
      if Coupon.pluck(:code).include?(params[:code])
        @coupon = Coupon.find_by(code: params[:code])
        unless UsedCoupon.find_by(coupon_id: @coupon.id, user_id: current_user.id).present?
          session[:coupon] = params[:code]
          @coupon = Coupon.find_by(code: session[:coupon])
          set_cart_item_detail
          @coupon_message = "Coupon applied successfully"

          respond_to do |format|
            format.js
          end
        else
          set_cart_item_detail
          @coupon_invalid_message = "Coupon already used "
        end
      else
        set_cart_item_detail
        @coupon_invalid_message = "Invalid Coupon"
        respond_to do |format|
          format.js
        end
      end
    else
      set_cart_item_detail
      @coupon_invalid_message = "Please enter coupon code"
      
      respond_to do |format|
        format.js
      end
    end
  end
    # redirect_to cart_items_path
    

  def remove_coupon
    if session[:coupon].present?
      session[:coupon] = nil
      set_cart_item_detail
      
      respond_to do |format|
        format.js
      end
    end
  end

  private
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def set_current_user_cart_items
      @cart_items = current_user.cart_items
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity, :product_id)
    end

    def cart_update_params
      params.permit(:quantity, :product_id)
    end

    def set_cart_item_detail
      val = current_user.cart_items.calculate_sum(session[:coupon])
      @cart_items_total = val[0]
      @vat = val[1]
      @shipping_cost = val[2]
      @grand_total = val[3]
      @discount_amount = val[4]
    end
end
