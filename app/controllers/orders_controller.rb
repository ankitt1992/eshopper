class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user_cart_items,  only: [:index, :payment, :create_charges]
  before_action :set_current_user_order, only: [:payment, :refund, :track, :create_charges]

  def index
    @orders = current_user.orders.order_status
  end

  def show
    @order = current_user.orders.find(params[:id])
    if @order.present?
      @order_items = @order.order_items
      @amount = @order.grand_total
      @address = @order.address
    else
      redirect_to root_url, alert: "You are not authorized to see this record"
    end
  end

  def create
    @order = current_user.orders.find_by(status: "pending")
    if @order.present?
      if @order.update(order_params)
        redirect_to payment_order_path(@order)
      end
    else
      @order = current_user.orders.new(order_params)
      if @order.save
        redirect_to payment_order_path(@order)
      end
    end
  end

  def payment
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
    if params[:stripeToken].present?
      if session[:coupon].present?
        @coupon = Coupon.find_by(code: session[:coupon])
        @coupon.no_of_uses = @coupon.no_of_uses.to_i + 1
        @coupon_id = @coupon.id
        @coupon.save
      end
      @order.update(status: "successfull", track_status: "ordered", coupon_id: @coupon_id)
      current_user.used_coupons.create(coupon_id: @coupon_id, order_id: @order.id)
      session[:coupon] = nil
      @cart_items.each do |cart_item|
        @order_item = OrderItem.create(order_id: params[:id], quantity: cart_item.quantity, sub_total: cart_item.total, product_id: cart_item.product_id)
      end
      @transaction = PaymentTransaction.create(order_id: @order.id, stripe_token: params[:stripeToken], stripe_email: params[:stripeEmail], stripe_token_type: params[:stripeTokenType], amount: @amount, paid: charge[:paid], charge_id: charge[:id], refunded: charge[:refunded])
      @cart_items.destroy_all
      OrderMailer.order_email(current_user, @order).deliver_now
    end

    redirect_to order_path(params[:id])
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to payment_order_path
  end

  def refund
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
    
  private
  def order_params
		params.require(:order).permit(:address_id, :status, :grand_total, :shipping_charges, :discount_amount)
	end

  def set_current_user_cart_items
    @cart_items = current_user.cart_items
  end

  def set_current_user_order
    @order = current_user.orders.find(params[:id])
  end
end
