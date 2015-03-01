class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @family = Family.new
  end
end
