class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_tournament
  has_many :picks

  delegate :tournament, to: :group_tournament
  delegate :matchups, to: :tournament

  def score
    picks.inject(0){|sum, p| sum + (p.winner ? 1 : 0) * 10 * (2 ** (tournament_slot_depth - p.slot.depth)) }
  end

  private

  def tournament_slot_depth
    tournament.slots.map(&:depth).max
  end
end
