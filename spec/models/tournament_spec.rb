require "rails_helper"

RSpec.describe Tournament, type: :model do
  let!(:tournament) { create :tournament }
  describe '#slot_depth' do
    context "with no depth" do
      let!(:first_round_slot1) { create :slot, tournament: tournament }
      let!(:first_round_slot2) { create :slot, tournament: tournament }
      it 'returns the depth of ancestry of the slots in the tournament' do
        expect(tournament.slot_depth).to eq 0
      end
    end
    context "with three layers of slots" do
      let!(:first_round_slot) { create :slot, tournament: tournament, parent: second_round_slot }
      let!(:second_round_slot) { create :slot, tournament: tournament, parent: third_round_slot }
      let!(:third_round_slot) { create :slot, tournament: tournament }
      it 'returns the depth of ancestry of the slots in the tournament' do
        expect(tournament.slot_depth).to eq 2
      end
    end
  end
end
