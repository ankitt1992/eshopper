class OrderMailer < ApplicationMailer
  def order_email(user,total, id, date)
    @user = user
    @amount = total
    @order_id = id
    @order_date = date
    attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/home/logo.png"))
    mail(to: @user.email,
      from: 'ankit.neosoft@gmail.com',
      subject: 'Your order has been placed '+@user.first_name,
      # text: 'This mail is sent using Mailgun API via mailgun-ruby'
      )
  end
end
