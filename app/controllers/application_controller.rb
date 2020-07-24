class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :friend_request_count

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def friend_request_count
    current_user.friend_requests.length
  end
end
