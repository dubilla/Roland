class Group < ActiveRecord::Base
  has_many :tournaments, through: :group_tournaments
end
