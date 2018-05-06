require "rails_helper"

describe "rake score_tournament:group_tournament", type: :task do
  let(:tournament) { create :tournament }
  let(:group) { create :group }
  let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }
  let(:user) { create :user }
  let(:entry) { create :entry, user: user, group_tournament: group_tournament }

  let(:winning_player) { create :player }
  let(:winning_slot) { create :slot }
  let(:winning_matchup) { create :matchup, slot: winning_slot }
  let(:winning_entrant) { create :entrant, player: winning_player }
  let!(:winning_opponent) { create :opponent, winner: true, matchup: winning_matchup, entrant: winning_entrant }
  let!(:winning_pick) { create :pick, entry: entry, slot: winning_slot, entrant: winning_entrant }

  let(:losing_player) { create :player }
  let(:other_winning_player) { create :player }
  let(:losing_slot) { create :slot }
  let(:losing_matchup) { create :matchup, slot: losing_slot }
  let(:losing_entrant) { create :entrant, player: losing_player }
  let(:other_winning_entrant) { create :entrant, player: other_winning_player }
  let!(:other_winning_opponent) { create :opponent, winner: true, matchup: losing_matchup, entrant: other_winning_entrant }
  let!(:losing_opponent) { create :opponent, winner: false, matchup: losing_matchup, entrant: losing_entrant }
  let!(:losing_pick) { create :pick, entry: entry, slot: losing_slot, entrant: losing_entrant }

  it "marks pick winners" do
    task.execute(group_tournament_id: group_tournament.id)
    expect(winning_pick.reload.winner).to be true
    expect(losing_pick.reload.winner).to be false
  end
end
