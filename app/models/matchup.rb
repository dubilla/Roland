class Matchup < ActiveRecord::Base
  belongs_to :slot
  has_many :opponents, inverse_of: :matchup
  has_many :entrants, through: :opponents

  accepts_nested_attributes_for :opponents

  delegate :name, to: :slot, prefix: true
  delegate :tournament, to: :slot

  def winner
    opponents.where(winner: true).first
  end
end
