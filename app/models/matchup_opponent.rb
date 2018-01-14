class MatchupOpponent < ActiveRecord::Base
  belongs_to :matchup
  belongs_to :opponent
end
