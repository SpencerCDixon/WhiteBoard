class FamiliesController < ApplicationController

  def create
    if FamilyBuilder.new(family_params, current_user).build
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

