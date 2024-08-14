# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_default_username, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def set_default_username
    if params[:user][:username].blank?
      params[:user][:username] = params[:user][:email]
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
  end
end
