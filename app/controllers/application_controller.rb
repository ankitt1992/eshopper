class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token  
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order
  before_filter :set_brand

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:first_name, :last_name,  :email, :password, :password_confirmation, :current_password)
    end
  end

  def set_brand
    @brands = Brand.where(status: true).all
  end
end
