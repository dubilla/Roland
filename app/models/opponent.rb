class Opponent < ActiveRecord::Base
  belongs_to :matchup
  belongs_to :entrant
end
