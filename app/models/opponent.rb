class Opponent < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :player
  has_many :picks
  has_many :matchup_opponents
  has_many :matchups, through: :matchup_opponents
end
