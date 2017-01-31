class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = current_user.cart_items.all
    @cart_items_total = current_user.cart_items.sum(:total)
    @vat = 0.04 * @cart_items_total
    if @cart_items_total < 500
      @shipping_cost = 40.to_f
      @grand_total = @cart_items_total + @vat + @shipping_cost
    else
      @shipping_cost = 'Free'
      @grand_total = @cart_items_total + @vat
    end
    @cart_item = CartItem.new
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart_items = current_user.cart_items.all
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user_id = current_user.id
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

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    @cart_item = CartItem.find(params[:id])
    if params[:increase].present? && @cart_item.product.quantity>0
      @cart_item.quantity+= 1
    elsif params[:decrease].present? && @cart_item.quantity > 1
      @cart_item.quantity -= 1
    elsif params[:cart_item][:quantity].to_i >0
      @cart_item.quantity = params[:cart_item][:quantity]
    end
    @cart_item.save
    @cart_items_total = current_user.cart_items.sum(:total) 
    @vat = 0.04 * @cart_items_total
    if @cart_items_total < 500
      @shipping_cost = 40.to_f
      @grand_total = @cart_items_total + @vat + @shipping_cost
    else
      @shipping_cost = 'Free'
      @grand_total = @cart_items_total + @vat
    end

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

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_items = current_user.cart_items.all
    @cart_item.destroy
    @cart_items_total = current_user.cart_items.sum(:total) 
    @vat = 0.04 * @cart_items_total
    @grand_total = @cart_items_total + @vat

    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully removed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity, :product_id)
    end

    def cart_update_params
      params.permit(:quantity, :product_id)
    end
end
