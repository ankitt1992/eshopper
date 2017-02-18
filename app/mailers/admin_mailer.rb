class AdminMailer < ApplicationMailer
	def contact_email(contact)
    @contact = contact
    attachments.inline['logo.png'] = File.read(Rails.root.join("app/assets/images/home/logo.png"))
    mail(to: 'ankit.neosoft@gmail.com',
      from: @contact.email,
      subject: @contact.subject,
      text: @contact.message
      )
  end
end
