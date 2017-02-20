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

    # if @cart_items_total < 500 && @cart_items_total > 0
    #   @shipping_cost = 40.to_f
    #   @grand_total = @cart_items_total + @vat + @shipping_cost
    # else
    #   @shipping_cost = 'Free'
    #   @grand_total = @cart_items_total + @vat
    # end

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
    # @cart_items_total = current_user.cart_items.sum(:total) 
    # @vat = 0.04 * @cart_items_total
    # @grand_total = @cart_items_total + @vat

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
      @cart_items = current_user.cart_items

      val = CartItem.calculate_sum(@cart_items)
      @cart_items_total = val[0]
      @vat = val[1]
      @shipping_cost = val[2]
      @grand_total = val[3]
      # @cart_items_total = @cart_items.sum(:total)
      # @vat = 0.04 * @cart_items_total
      # if @cart_items_total < 500
      #   @shipping_cost = 40.to_f
      #   @grand_total = @cart_items_total + @vat + @shipping_cost
      # else
      #   @shipping_cost = 'Free'
      #   @grand_total = @cart_items_total + @vat
      # end
      # @cart_item = CartItem.new
    end
end
