class Tournament < ActiveRecord::Base
  has_many :groups, through: :group_tournaments
  has_many :slots
  has_many :matchups, through: :slots

  scope :unstarted, -> { where("start_date >= ? ", Date.today) }
end
