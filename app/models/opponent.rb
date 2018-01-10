class Opponent < ActiveRecord::Base
  belongs_to :matchup
  has_many :picks
end
