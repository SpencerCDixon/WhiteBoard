class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @family = Family.new
    @invitation = Invitation.new
    @families = current_user.families
  end
end
