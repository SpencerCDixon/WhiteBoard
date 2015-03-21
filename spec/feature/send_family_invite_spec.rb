require 'rails_helper'

feature 'send family invitations' do
  context 'authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    before :each do
      sign_in_as user
      visit profile_path
    end

    scenario 'only shows invite if user has a family' do
      expect(page).to_not have_content("Invite Family Members")
      FactoryGirl.create(:family_membership, user: user)

      visit profile_path
      expect(page).to have_content("Invite Family Members")
    end

    scenario 'successfully creates an invitation' do
      family = FactoryGirl.create(:family_membership, user: user).family
      visit profile_path

      within '#new_invitation' do
        fill_in 'Name', with: 'Emily Wadsworth'
        fill_in 'Email', with: 'e.wadsworth@gmail.com'
        select family.name, from: 'Family'
        click_on 'Send Invite'
      end

      expect(page).to have_content('Successfully sent invitation')

      within '.all_invites' do
        expect(page).to have_content('Emily Wadsworth')
        expect(page).to have_content('e.wadsworth@gmail.com')
        expect(page).to have_content('Pending')
      end
    end

    scenario 'notifies user if there are errors sending invite' do
      family = FactoryGirl.create(:family_membership, user: user).family
      visit profile_path

      within '#new_invitation' do
        click_on 'Send Invite'
      end

      expect(page).to have_content('Something went wrong. Please fix errors')
    end
  end
end
