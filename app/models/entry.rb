class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_tournament
  has_many :picks

  delegate :tournament, to: :group_tournament
  delegate :matchups, to: :tournament

  def score
    EntryScore.new(picks, tournament.slot_depth)
  end
end
