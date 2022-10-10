class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :set_customer_role_on_sign_up, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def set_customer_role_on_sign_up
    if controller_name == 'registrations' && action_name == 'create' && params[:user].present?
      params[:user][:role] = 'customer'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit( :sign_up, keys: [:name, :email, :password, :address, :date_of_birth, :phone, :gender, :role ] )
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
