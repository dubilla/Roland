class Opponent < ActiveRecord::Base
  belongs_to :tournament
  has_many :picks
end
