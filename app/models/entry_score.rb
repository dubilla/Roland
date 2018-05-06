class EntryScore
  attr_reader :picks, :tournament_round_count

  def initialize(picks, tournament_round_count)
    @picks, @tournament_round_count = picks, tournament_round_count
  end

  def points
    @picks.inject(0) do |sum, p|
      sum + (p.winner ? 1 : 0) * 10 * (2 ** (tournament_round_count - p.slot.depth))
    end
  end
end
