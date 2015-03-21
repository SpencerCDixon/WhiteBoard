require 'rails_helper'

feature 'families' do
  context 'as authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'create new family' do
      sign_in_as user
      visit profile_path

      fill_in 'Name', with: 'Wadsworth Family'
      click_on 'Create Family'

      expect(page).to have_content('Successfully created family.')
      # this logic should go in model tests
      # expect(FamilyMembership.count).to eq 1
      # expect(Family.count).to eq 1
    end
  end
end
