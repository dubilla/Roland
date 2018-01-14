class Matchup < ActiveRecord::Base
  belongs_to :slot
  has_many :opponents, inverse_of: :matchup
  has_many :entrants, through: :opponents

  delegate :name, to: :slot, prefix: true
end
