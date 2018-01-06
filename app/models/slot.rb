class Slot < ActiveRecord::Base
  belongs_to :tournament
  has_many :picks
end
