class SessionsController < ApplicationController
  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = user.id
    redirect_to profile_path
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "Signed out successfully."
    redirect_to root_path
  end

  def failure
    redirect_to root_path, notice: "Unable to sign in."
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
