class Matchup < ActiveRecord::Base
  belongs_to :slot
  has_many :opponents
end
