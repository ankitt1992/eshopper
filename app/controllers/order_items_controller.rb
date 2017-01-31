class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!

  # GET /order_items
  # GET /order_items.json
  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    if current_user.present?
      @order_item.user_id = current_user.id
    end
    @order.save
    session[:order_id] = @order.id

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to carts_path, notice: 'Item was successfully Added.' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    # @order = current_order
    # @order_item = @order.order_items.find(params[:id])
    @order_item = OrderItem.find(params[:id])
    @order_item.update(cart_params)
    if current_user.present?
      @order_item.user_id = current_user.id
    end
    # @order_items = @order.order_items

    respond_to do |format|
      if @order_item.update(cart_params)
        format.html { redirect_to carts_path, notice: 'Item was successfully updated.' }
        # format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    # @order = current_order
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    # @order_items = @order.order_items

    respond_to do |format|
      format.html { redirect_to carts_path, notice: 'Item was successfully removed from cart.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:quantity, :amount, :order_id, :product_id, :sub_total)
    end

    def cart_params
      params.permit(:quantity)
    end
end
