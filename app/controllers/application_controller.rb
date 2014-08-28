class ApplicationController < ActionController::Base
  respond_to :html, :xml
  #protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
  end
end