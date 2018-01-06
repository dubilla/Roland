class Tournament < ActiveRecord::Base
  has_many :groups, through: :group_tournaments
  has_many :slots
  has_many :opponents

  scope :unstarted, -> { where("start_date >= ? ", Date.today) }
end
