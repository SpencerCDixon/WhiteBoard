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

    scenario 'sends email invitation' do
      ActionMailer::Base.deliveries = []

      prev_count = Invitation.count
      family = FactoryGirl.create(:family_membership, user: user).family
      visit profile_path

      within '#new_invitation' do
        fill_in 'Name', with: 'Emily Wadsworth'
        fill_in 'Email', with: 'e.wadsworth@gmail.com'
        click_on 'Send Invite'
      end

      expect(page).to have_content('Successfully sent invitation')
      expect(Invitation.count).to eq(prev_count + 1)
      expect(ActionMailer::Base.deliveries.size).to eql(1)

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email).to have_subject('WhiteBoard Family Invitation')
      expect(last_email).to deliver_to('e.wadsworth@gmail.com')
    end

    scenario 'sender adds new member to the family after confirmation' do
      family = FactoryGirl.create(:family_membership, user: user).family
      invitation = FactoryGirl.create(:invitation, sender_id: user.id, family_id: family.id)
      child = FactoryGirl.create(:user, invite_token: invitation.invite_token)

      visit invitations_path
      click_on 'Add To Family'

      expect(page).to have_content('Successfully added to family.')
      expect(page).to have_content('Accepted')

      visit profile_path

      within '.family-members' do
        expect(page).to have_content(child.name)
      end
    end

    scenario 'recipient updates their invite status' do
      family = FactoryGirl.create(:family_membership, user: user).family
      invitation = FactoryGirl.create(:invitation, sender_id: user.id, family_id: family.id)
      child = FactoryGirl.create(:user, invite_token: invitation.invite_token)

      click_on 'Sign Out'
      sign_in_as child
      click_on 'Account Settings'

      fill_in 'Invite token', with: invitation.invite_token
      click_on 'Join Family'

      expect(page).to have_content('Success.  Waiting for confirmation')
    end
  end
end
