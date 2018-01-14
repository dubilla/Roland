require "rails_helper"

RSpec.feature "Picks", type: :feature do
  let(:user) { create :user }
  let(:tournament) { create :tournament }
  let(:player1) { create :player }
  let(:player2) { create :player }
  let(:player3) { create :player }
  let(:player4) { create :player }
  let(:player5) { create :player }
  let(:player6) { create :player }
  let(:player7) { create :player }
  let(:player8) { create :player }
  let!(:opponent1) { create :opponent, tournament: tournament, name: "Clemson", player: player1 }
  let!(:opponent2) { create :opponent, tournament: tournament, name: "Alabama", player: player2 }
  let!(:opponent3) { create :opponent, tournament: tournament, name: "Georgia", player: player3 }
  let!(:opponent4) { create :opponent, tournament: tournament, name: "Oklahoma", player: player4 }
  let!(:opponent5) { create :opponent, tournament: tournament, name: "Ohio State", player: player5 }
  let!(:opponent6) { create :opponent, tournament: tournament, name: "USC", player: player6 }
  let!(:opponent7) { create :opponent, tournament: tournament, name: "Auburn", player: player7 }
  let!(:opponent8) { create :opponent, tournament: tournament, name: "UCF", player: player8 }
  let!(:slot_round3) { create :slot, tournament: tournament, name: "Slot 7" }
  let!(:slot_round2_a) { create :slot, tournament: tournament, name: "Slot 5", parent: slot_round3 }
  let!(:slot_round2_b) { create :slot, tournament: tournament, name: "Slot 6", parent: slot_round3 }
  let!(:slot_round1_a) { create :slot, tournament: tournament, name: "Slot 1", parent: slot_round2_a }
  let!(:slot_round1_b) { create :slot, tournament: tournament, name: "Slot 2", parent: slot_round2_a }
  let!(:slot_round1_c) { create :slot, tournament: tournament, name: "Slot 3", parent: slot_round2_b }
  let!(:slot_round1_d) { create :slot, tournament: tournament, name: "Slot 4", parent: slot_round2_b }
  let(:matchup1) { create :matchup, slot: slot_round1_a }
  let(:matchup2) { create :matchup, slot: slot_round1_b }
  let(:matchup3) { create :matchup, slot: slot_round1_c }
  let(:matchup4) { create :matchup, slot: slot_round1_d }
  let!(:matchup_opponent1) { create :matchup_opponent, matchup: matchup1, opponent: opponent1 }
  let!(:matchup_opponent2) { create :matchup_opponent, matchup: matchup1, opponent: opponent2 }
  let!(:matchup_opponent3) { create :matchup_opponent, matchup: matchup2, opponent: opponent3 }
  let!(:matchup_opponent4) { create :matchup_opponent, matchup: matchup2, opponent: opponent4 }
  let!(:matchup_opponent5) { create :matchup_opponent, matchup: matchup3, opponent: opponent5 }
  let!(:matchup_opponent6) { create :matchup_opponent, matchup: matchup3, opponent: opponent6 }
  let!(:matchup_opponent7) { create :matchup_opponent, matchup: matchup4, opponent: opponent7 }
  let!(:matchup_opponent8) { create :matchup_opponent, matchup: matchup4, opponent: opponent8 }
  let(:group) { create :group }
  let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }
  let(:entry) { create :entry, user: user, group_tournament: group_tournament, name: "My First" }
  let!(:pick1) { create :pick, entry: entry, slot: slot_round1_a }
  let!(:pick2) { create :pick, entry: entry, slot: slot_round1_b }
  let!(:pick3) { create :pick, entry: entry, slot: slot_round1_c }
  let!(:pick4) { create :pick, entry: entry, slot: slot_round1_d }
  let!(:pick5) { create :pick, entry: entry, slot: slot_round2_a }
  let!(:pick6) { create :pick, entry: entry, slot: slot_round2_b }
  let!(:pick7) { create :pick, entry: entry, slot: slot_round3 }

  scenario "making a pick in a later round" do
    as_a_user_i_login user
    given_i_have_an_entry
    and_i_visit_my_entry_page
    i_can_pick_a_game
    and_i_only_see_the_possible_opponents
    make_a_pick
    and_see_the_pick_on_the_entry_page
    and_i_see_the_preceding_picks
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def given_i_have_an_entry
    #no-op
  end

  def and_i_visit_my_entry_page
    visit group_tournament_entry_path group_tournament, entry
  end

  def i_can_pick_a_game
    find("div", text: "Pick Slot 5").click_link "Make Pick"
    expect(page).to have_text "Pick for Slot 5"
  end

  def and_i_only_see_the_possible_opponents
    expect(page).to have_select "Winner", ["Clemson", "Alabama", "Georgia", "Oklahoma"]
  end

  def make_a_pick
    select "Clemson", from: "Winner"
    click_button "Make Pick"
  end

  def and_see_the_pick_on_the_entry_page
    expect(page).to have_text "My First Entry"
    within "section", text: "Pick Slot 5" do
      expect(page).to have_text "Pick: Clemson"
    end
  end

  def and_i_see_the_preceding_picks
    within "section", text: "Pick Slot 1" do
      expect(page).to have_text "Pick: Clemson"
    end
  end
end
