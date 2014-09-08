class ApplicationController < ActionController::Base
  include Pundit
  respond_to :html, :json, :xml
  skip_before_filter :verify_authenticity_token, if: :xml_request?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, :with => :not_authorized

  def authorize_admin
    authorize :admin, "#{action_name}?".to_sym
  end

  def authorize_supervisor
    authorize :supervisor, "#{action_name}?".to_sym
  end

  protected

  def not_authorized
    redirect_to root_path, alert: 'No tiene permiso para ver ese recurso'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :fullname
  end

  def xml_request?
    request.format.xml?
  end
end
