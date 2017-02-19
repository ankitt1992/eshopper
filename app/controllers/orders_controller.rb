class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @cart_items = current_user.cart_items
    end
    @orders = current_user.orders.where('status =? or status=?', "successfull","cancelled").order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
    if current_user.orders.pluck('id').include?(@order.id)
      @order_items = @order.order_items
      @amount = @order.grand_total
      @address = Address.find(@order.address_id)
    else
      redirect_to root_url, alert: "You are not authorized to see this record"
    end
  end

  def new
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
    @amount = charge[:amount].to_f/100
    @order = Order.find(params[:id])
    if params[:stripeToken].present?
      @cart_items = current_user.cart_items
      @order.update(status: "successfull", track_status: "ordered")
      
      @cart_items.each do |cart_item|
        @order_item = OrderItem.create(order_id: params[:id], quantity: cart_item.quantity, sub_total: cart_item.total, product_id: cart_item.product_id)
      end
      @transaction = PaymentTransaction.create(order_id: @order.id, stripe_token: params[:stripeToken], stripe_email: params[:stripeEmail], stripe_token_type: params[:stripeTokenType], amount: @amount, paid: charge[:paid], charge_id: charge[:id], refunded: charge[:refunded])
      current_user.cart_items.destroy_all
      OrderMailer.order_email(current_user,@amount, @order.id, @order.created_at).deliver_now
    end

    redirect_to order_path(params[:id])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to payment_order_path
  end

  def refund
    @order = Order.find(params[:id])
    @transaction = @order.payment_transaction
    @payment_charge = @transaction.charge_id
    charge = Stripe::Charge.retrieve(@payment_charge)
    if charge.refund
      @transaction.update(refunded: charge[:refunded], refunded_date: Time.now.to_date)

      if @order.update(status: "cancelled")
        redirect_to orders_path
      end
    end
  end

  def track
    @order = Order.find(params[:id])
  end
    
  private
  def order_params
		params.require(:order).permit(:address_id, :status, :grand_total)
	end
end
