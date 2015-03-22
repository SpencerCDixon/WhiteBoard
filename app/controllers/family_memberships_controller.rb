class FamilyMembershipsController < ApplicationController
  def create
    membership = FamilyMembership.new(user_id: params["user_id"],
                                      family_id: params["family_id"])
    invitation = Invitation.find(params["invite_id"])

    if membership.save
      flash[:info] = "Successfully added to family."
      invitation.update_attributes(status: "accepted")
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to :back
  end
end
