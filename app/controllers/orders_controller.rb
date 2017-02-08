class OrdersController < ApplicationController
	def new
		
		# @cart_items_total = current_user.cart_items.sum(:total) 
    # @vat = 0.04 * @cart_items_total
    # @grand_total = @cart_items_total + @vat
		# @order = current_user.orders.new(address_id: params[:address_id], grand_total: @grand_total, status: "pending")
		# @order.save

	end

	def payment
    if user_signed_in?
      @cart_items = current_user.cart_items.all
    end
    @order = Order.find(params[:id])
    if @order.status=="successfull" 
      redirect_to root_url 
    else
		  @grand_total = @order.grand_total.to_f
    end
	end

	def create

    @order = current_user.orders.find_by(status: "pending")
    if @order.present?
      if @order.update(grand_total: params[:order][:grand_total])
        redirect_to payment_order_path(@order)
      end
    else
		  @order = current_user.orders.new(order_params)
      respond_to do |format|
      if @order.save
        format.html { redirect_to payment_order_path(@order)}
      end
    end
    end
  end


  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @amount = @order.grand_total
    @address = Address.find(@order.address_id)
  end



  def create_charges
   @amount = (current_user.orders.last.grand_total * 100).to_i 
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'inr'
    )
    @order = Order.find(params[:id])
    if params[:stripeToken].present?
      @cart_items = current_user.cart_items
      @order.update(status: "successfull", :transaction_id=> params[:stripeToken])
      
      @cart_items.each do |cart_item|
        @order_item = OrderItem.create(order_id: params[:id], quantity: cart_item.quantity, sub_total: cart_item.total, product_id: cart_item.product_id)
      end
      current_user.cart_items.destroy_all
      OrderMailer.order_email(current_user,@amount, @order.id, @order.created_at).deliver_now
    end

    redirect_to order_path(params[:id])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to payment_order_path
  end
	  
	private
	def order_params
		params.require(:order).permit(:address_id, :status, :grand_total)
	end

end
