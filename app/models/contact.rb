class Contact < ActiveRecord::Base

	after_create :send_admin_contact_us_mail
	after_update :send_user_contact_us_reply_mail

  def send_admin_contact_us_mail
  	AdminMailer.contact_email(self).deliver_now
  end

  def send_user_contact_us_reply_mail
    UserMailer.reply_email(self).deliver
  end

end
