class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2,:twitter]
  has_many :cart_items

  after_create :send_admin_mail
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # if(auth.provider== "twitter")
      #   user.email= Array.new(6){rand(36).to_s(36)}.join.concat('@gmail.com')
      # else
      user.email = auth.info.email
      # end
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name 

      # uri = URI.parse(auth.info.image)
      # uri.scheme = 'https'
      # user.update_attribute(:avatar, URI.parse(uri))
      # url= auth.info.image # assuming the user model has an image
      # user.avatar = url.gsub("http","https")
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end


  def send_admin_mail
    UserMailer.welcome_email(self).deliver
  end
end
