class Matchup < ActiveRecord::Base
  belongs_to :slot
  has_many :opponents, inverse_of: :matchup
  has_many :entrants, through: :opponents
end
