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
end
