class Tournament < ActiveRecord::Base
  has_many :groups, through: :group_tournaments

  scope :unstarted, -> { where("start_date >= ? ", Date.today) }
end
