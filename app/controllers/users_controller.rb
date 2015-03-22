class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes(invite_token: params["user"]["invite_token"])
    invite = Invitation.find_by(invite_token: params["user"]["invite_token"])
    invite.status = "sent"
    if invite.save
      flash[:info] = "Success.  Waiting for confirmation"
    end
    redirect_to root_path
  end
end
