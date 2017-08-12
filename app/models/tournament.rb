class Tournament < ActiveRecord::Base
  has_many :groups, through: :group_tournaments
end
