class OrderMailer < ApplicationMailer
  def order_email(user, order)
    @user = user
    @order = order
    @address = @order.address
    @order_items = @order.order_items
    @order_items_total = @order_items.sum(:sub_total)
    @discount_amount = @order.discount_amount
    unless @discount_amount.present?
      @discount_amount = 0
    end
    @shipping_cost = @order.shipping_charges
    @vat = 0.04 * (@order_items_total - @discount_amount)
    attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/home/logo.png"))
    mail(to: @user.email,
      from: 'ankit.neosoft@gmail.com',
      subject: 'Your order has been placed '+@user.first_name
      )
  end
end
