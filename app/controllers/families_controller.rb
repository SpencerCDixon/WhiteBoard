class FamiliesController < ApplicationController

  def create
    family = Family.new(family_params)

    if family.save
      FamilyMembership.create(family: family, user: current_user)
      flash[:info] = "Successfully created family."
    else
      flash[:alert] = "Family wasn't saved."
    end
    redirect_to profile_path
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end

