class User < ActiveRecord::Base
  has_many :family_memberships

  has_many :families,
    through: :family_memberships

  has_many :sent_invitations,
    class_name: "Invitation",
    foreign_key: "sender_id"

  belongs_to :invitation

  validates :name,
    presence: true

  validates :email,
    presence: true,
    uniqueness: true

  validates :uid,
    presence: true,
    uniqueness: { scope: :provider }

  validates :provider,
    presence: true

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }

    User.find_or_create_by(account_keys) do |user|
      user.email = auth["info"]["email"]
      user.name = auth["info"]["name"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.image = auth["info"]["image"] # or some default image here
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
