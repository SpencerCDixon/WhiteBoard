require 'rails_helper'

describe Invitation do
  describe "#send_invite" do
    it 'sends an email when parking is successful' do
      prev_mail_count = ActionMailer::Base.deliveries.count
      user = FactoryGirl.create(:user)
      family = FactoryGirl.create(:family_membership, user: user).family

      invitation = FactoryGirl.create(:family_invitation,
                                      sender_id: user.id,
                                      family_id: family.id)
      invitation.send_invite
      expect(ActionMailer::Base.deliveries.count).to eql(prev_mail_count + 1)
    end
  end

  describe "#user_in_system?" do
    it 'returns user successfully' do
      user = FactoryGirl.create(:user, email: "spencercdixon@gmail.com")
      family = FactoryGirl.create(:family)
      invitation = FactoryGirl.create(:invitation, email: user.email, family_id: family.id, sender_id: 1)
      expect(invitation.check_for_user).to eq user
    end

    it 'returns false if user is not in system' do
      invitation = FactoryGirl.create(:invitation, email: 'example@email.com')
      expect(invitation.check_for_user).to eq false
    end
  end
end
