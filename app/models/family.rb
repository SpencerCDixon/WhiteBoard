class Family < ActiveRecord::Base
  has_many :family_memberships
  has_many :users,
    through: :family_memberships

  has_many :invitations
  belongs_to :user
end
