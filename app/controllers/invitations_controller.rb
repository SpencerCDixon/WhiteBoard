class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def index
    @invitations = current_user.sent_invitations
  end

  def create
    invitation = Invitation.new(invitation_params)
    binding.pry
    invitation.sender = current_user
    invitation.family = current_user.family

    if invitation.send_invite
      flash[:info] = "Successfully sent invitation"
      redirect_to invitations_path
    else
      redirect_to :back,
        alert: "Something went wrong. Please fix errors"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:name, :email)
  end
end
