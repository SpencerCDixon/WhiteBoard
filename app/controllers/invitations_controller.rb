class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    binding.pry
  end

  private

  def invitation_params
    params.require(:invitation).permit(:name, :email, :family_id)
  end
end
