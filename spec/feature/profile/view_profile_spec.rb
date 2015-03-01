require 'rails_helper'

feature 'view profile' do
  context 'as an authroized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'I can view profile page' do
      visit profile_path

      expect(page).to have_content("Welcome back #{user.name}")
    end
  end

  context 'as a visitor' do
    scenario 'I get redirected to root path' do
      visit profile_path

      expect(page).to have_content("Must be signed in.")
    end
  end
end
