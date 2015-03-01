class Family < ActiveRecord::Base
  has_many :family_memberships
  belongs_to :user
end
