class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @new_family = Family.new
    @invitation = Invitation.new
    @current_family = current_user.family
  end
end
