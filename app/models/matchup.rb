class Matchup < ActiveRecord::Base
  belongs_to :slot
  has_many :matchup_opponents
  has_many :opponents, through: :matchup_opponents
end
