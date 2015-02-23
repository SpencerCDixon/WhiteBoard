class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  include SessionHelper

  def authenticate_user!
    authenticate_via_session
  end

  # def authorize_admin!
    # if !user_signed_in? || !current_user.admin?
      # not_found
    # end
  # end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  def unauthorized!
    render status: :unauthorized
  end

  private

  def authenticate_via_session
    if !user_signed_in?
      flash[:info] = "Must be signed in."
      redirect_to_back_or_root
    end
  end

  def redirect_to_back_or_root
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
end
