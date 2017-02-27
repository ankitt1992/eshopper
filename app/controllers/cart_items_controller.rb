class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user_cart_items, only: [:index, :create, :destroy, :review_and_payment]
  before_action :set_cart_item, only: [:update, :destroy]
  before_action :set_cart_item_detail, only: [:index, :check_out, :review_and_payment]

  def create
    @cart_item = @cart_items.find_or_initialize_by(cart_item_params)
    @product = @cart_item.product
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_items_path, notice: 'Item was successfully added.' }
        format.js
      else
        format.html { redirect_to root_url, notice: 'Item not added'}
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

    respond_to do |format|
      if @cart_item.update(cart_update_params)
        set_cart_item_detail
        format.html { redirect_to cart_items_path, notice: 'Cart item was successfully updated.' }
        format.js
      else
        format.html { redirect_to root_url, notice: 'Item not updated' }
      end
    end
  end

  def destroy
    @cart_item.destroy
    set_cart_item_detail

    respond_to do |format|
      format.html { redirect_to cart_items_path, notice: 'Cart item was successfully removed.' }
      format.js
    end
  end

  def check_out
    @address= current_user.addresses.new
  end


  def apply_coupon
    if params[:code].present?
      @coupon = Coupon.find_by(code: params[:code])
      if @coupon.present?
        @used_coupon = current_user.used_coupons.find_by(coupon_id: @coupon.id)
        unless @used_coupon.present?
          session[:coupon] = params[:code]
          @coupon = Coupon.find_by(code: session[:coupon])
          set_cart_item_detail
          @coupon_message = "Coupon applied successfully"

          respond_to do |format|
            format.js
          end
        else
          set_cart_item_detail
          @coupon_invalid_message = "Coupon already used"
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

  def remove_coupon
    if session[:coupon].present?
      session[:coupon] = nil
      set_cart_item_detail
      
      respond_to do |format|
        format.js
      end
    end
  end

  def review_and_payment
    if @cart_items.present? 
      @order= current_user.orders.new
    else
      redirect_to root_url 
    end
  end
  
  private
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity, :product_id)
    end

    def cart_update_params
      params.permit(:quantity, :product_id)
    end

    def set_cart_item_detail
      cart_item_values = current_user.cart_items.calculate_sum(session[:coupon])
      @cart_items_total = cart_item_values[:cart_items_total]
      @vat = cart_item_values[:vat]
      @shipping_cost = cart_item_values[:shipping_cost]
      @grand_total = cart_item_values[:grand_total]
      @discount_amount = cart_item_values[:discount_amount]
    end
end
