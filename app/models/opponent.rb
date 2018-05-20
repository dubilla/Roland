class Opponent < ActiveRecord::Base
  belongs_to :matchup
  belongs_to :entrant

  delegate :player_name, to: :entrant
end
