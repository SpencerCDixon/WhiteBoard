class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.new(invitation_params)
    invitation.sender = current_user

    if invitation.send_invite
      flash[:info] = "Successfully sent invitation"
      redirect_to invitations_path
    else
      redirect_to :back,
        alert: "Something went wrong. Please fix errors"
    end
  end

  def index
    @invitations = current_user.sent_invitations
  end

  private

  def invitation_params
    params.require(:invitation).permit(:name, :email, :family_id)
  end
end
