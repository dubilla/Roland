require "rails_helper"

RSpec.describe Entry, type: :model do
  describe '#score' do
    let(:user) { create :user }
    let(:group) { create :group }
    let(:tournament) { create :tournament }
    let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }
    let!(:entry) { create :entry, user: user, group_tournament: group_tournament }
    context 'there is one depth' do
      let!(:first_round_slot1) { create :slot, tournament: tournament }
      let!(:first_round_slot2) { create :slot, tournament: tournament }
      let!(:first_round_winner_pick) { create :pick, winner: true, entry: entry, slot: first_round_slot1 }
      let!(:first_round_loser_pick) { create :pick, winner: false, entry: entry, slot: first_round_slot2 }
      it 'sums up correctly' do
        expect(entry.score).to eq 10
      end
    end
    context 'there is three levels of depth' do
      let(:first_round_slot) { create :slot, tournament: tournament, parent: second_round_slot1 }
      let(:second_round_slot1) { create :slot, tournament: tournament, parent: third_round_slot1 }
      let(:second_round_slot2) { create :slot, tournament: tournament, parent: third_round_slot2 }
      let(:third_round_slot1) { create :slot, tournament: tournament }
      let(:third_round_slot2) { create :slot, tournament: tournament }
      let!(:first_round_winner_pick) { create :pick, winner: true, entry: entry, slot: first_round_slot }
      let!(:second_round_winner_pick) { create :pick, winner: true, entry: entry, slot: second_round_slot1 }
      let!(:second_round_loser_pick) { create :pick, winner: false, entry: entry, slot: second_round_slot2 }
      let!(:third_round_winner_pick1) { create :pick, winner: true, entry: entry, slot: third_round_slot1 }
      let!(:third_round_winner_pick2) { create :pick, winner: true, entry: entry, slot: third_round_slot2 }
      it 'sums up correctly' do
        expect(entry.score).to eq 110
      end
    end
  end
end
