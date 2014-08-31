class ApplicationController < ActionController::Base
  respond_to :html, :xml
  skip_before_filter :verify_authenticity_token, if: :xml_request?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
  end

  def xml_request?
    request.format.xml?
  end
end