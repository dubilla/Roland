class Matchup < ActiveRecord::Base
  belongs_to :tournament
  has_many :slots
end
