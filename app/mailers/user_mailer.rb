class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/home/logo.png"))
    mail(to: @user.email,
      from: 'ankit.neosoft@gmail.com',
      subject: 'Welcome to Eshopper '+@user.first_name,
      # text: 'This mail is sent using Mailgun API via mailgun-ruby'
      )
  end

  def reply_email(contact)
  	@contact = contact
  	attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/home/logo.png"))
    mail(to: @contact.email,
      from: 'ankit.neosoft@gmail.com',
      subject: 'Reply to your query ' +@contact.name,
      # text: 'This mail is sent using Mailgun API via mailgun-ruby'
      )
  end
end
