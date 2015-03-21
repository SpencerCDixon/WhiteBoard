class Invitation < ActiveRecord::Base
  belongs_to :sender,
    class_name: "User"

  belongs_to :family

  has_one :recipient,
    class_name: "User"

  validates :name,
    presence: true

  validates :email,
    presence: true

  validates :family_id,
    presence: true

  validates :status,
    inclusion: { in: %w(pending sent accepted) }

  # validate :recipient_is_not_registered

  before_create :generate_token

  def send_invite
    self.sent_at = Date.today
    if save
      FamilyInvitation.invite(self).deliver_now
      true
    end
  end

  private

  def generate_token
    self.invite_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  # def recipient_is_not_registered
    # errors.add :email, 'is already registered' if User.find_by(email: email, family_id: family_id)
  # end
end
