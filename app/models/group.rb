class Group < ActiveRecord::Base
  has_many :tournaments, through: :group_tournaments
  has_many :group_memberships
  has_many :users, through: :group_memberships
end
