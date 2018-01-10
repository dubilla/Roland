class Slot < ActiveRecord::Base
  belongs_to :tournament
  has_ancestry
  has_one :matchup
  has_many :picks
end
