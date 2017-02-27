class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # skip_before_filter :verify_authenticity_token  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::RoutingError, with: :routing_error_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

  def render_unprocessable_entity_response(exception)
    respond_to do |format|
      format.html { render partial: 'home/not_found', alert: 'Record Not Found' }
    end
  end

  def record_not_found_response(exception)
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  def routing_error_response
    respond_to do |f| 
      f.html{ render :partial => "home/not_found", :status => 404 }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:first_name, :last_name,  :email, :password, :password_confirmation, :current_password)
    end
  end

  def set_brands
    @brands = Brand.where(status: true)
  end

  def initialize_cart_item
    @cart_item = CartItem.new
  end

  def set_current_user_cart_items
    if user_signed_in?
      @cart_items = current_user.cart_items
    end
  end
  
end
