class OrdersController < ApplicationController
	def new
		
		# @cart_items_total = current_user.cart_items.sum(:total) 
  #   @vat = 0.04 * @cart_items_total
  #   @grand_total = @cart_items_total + @vat
		# @order = current_user.orders.new(address_id: params[:address_id], grand_total: @grand_total, status: "pending")
		# @order.save

	end

	def payment
		
	end

	def create
		@order = current_user.orders.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to payment_order_path(@order)}
      end
    end
  end


  def show

  end



  def create_charges
   # Amount in cents
   @amount=50000
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    @order = Order.find(params[:id])
    @order = @order.update(status: "successfull", transaction_id: params[:stripeToken])
    
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    
  end
	  
	private
	def order_params
		params.require(:order).permit(:address_id, :status,:grand_total)
	end

end
