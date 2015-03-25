class Family < ActiveRecord::Base
  has_many :family_memberships
  has_many :users,
    through: :family_memberships

  has_many :invitations
  belongs_to :user

  # validate :family_exists?

  # def family_exists?
    # binding.pry
    # errors.add :family_exists, 'is already created' unless user.family.nil?
  # end
end
