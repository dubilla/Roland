require "rails_helper"

RSpec.feature "Entries", type: :feature do
  let(:user) { create :user, email: 'jason.day@golf.com' }
  let(:group) { create :group, name: 'Pool' }
  let(:tournament) { create :tournament, name: 'Denver Open', locked: false }
  let!(:slot) { create :slot, tournament: tournament }
  let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }
  let!(:nadal_entrant) { create :entrant, player: nadal }
  let!(:federer_entrant) { create :entrant, player: federer }
  let!(:del_potro_entrant) { create :entrant, player: del_potro }
  let!(:murray_entrant) { create :entrant, player: murray }
  let!(:nadal) { create :player, first_name: "Rafael", last_name: "Nadal" }
  let!(:federer) { create :player, first_name: "Rodger", last_name: "Federer" }
  let!(:del_potro) { create :player, first_name: "Juan", last_name: "Del Potro" }
  let!(:murray) { create :player, first_name: "Andy", last_name: "Murray" }

  context "with no existing entries" do
    scenario "creating and deleting entries" do
      as_a_user_i_login user
      and_i_visit_a_group_tournament_page
      i_can_create_an_entry
      get_redirected_to_the_group_tournament_page
      and_see_my_entry_listed
      and_i_cannot_create_another_entry
      i_can_delete_my_entry
      and_i_no_longer_see_it
    end

    def i_can_create_an_entry
      click_link 'Create an entry'
      expect(page).to have_text 'Create Entry'
      fill_in 'Name', with: 'my entry'
      click_button 'Create Entry'
    end

    def get_redirected_to_the_group_tournament_page
      expect(page).to have_text 'Denver Open'
    end

    def and_see_my_entry_listed
      expect(page).to have_text 'my entry'
    end

    def and_i_cannot_create_another_entry
      expect(page).to have_no_link "Create an entry"
    end

    def i_can_delete_my_entry
      click_link 'Delete'
    end

    def and_i_no_longer_see_it
      expect(page).to have_text 'Denver Open'
      expect(page).to have_no_text 'My entry'
    end
  end

  context "with an existing, unlocked entry" do
    let!(:entry) { create :entry, name: "My Bracket", user: user, group_tournament: group_tournament }
    let!(:slot1) { create :slot, tournament: tournament, name: "Matchup 1" }
    let!(:slot2) { create :slot, tournament: tournament, name: "Matchup 2" }
    let!(:matchup1) { create :matchup, slot: slot1 }
    let!(:matchup2) { create :matchup, slot: slot2 }
    let!(:pick_for_slot1) { create :pick, entry: entry, slot: slot1, entrant: nadal_entrant }
    let!(:pick_for_slot2) { create :pick, entry: entry, slot: slot2, entrant: federer_entrant }

    scenario "updating an entry with picks" do
      as_a_user_i_login user
      given_i_have_an_entry
      and_i_visit_a_group_tournament_page
      and_i_click_on_the_link_to_my_entry
      i_see_my_bracket
    end

    def given_i_have_an_entry
      #no-op
    end

    def and_i_click_on_the_link_to_my_entry
      find("tr", text: entry.name).click_link("View")
    end

    def i_see_my_bracket
      expect(page).to have_text "My Bracket Entry"
      expect(page).to have_text "Edit Pick", count: 2
    end
  end

  context "with locked entry" do
    let(:tournament) { create :tournament, name: 'Denver Open', locked: true }
    let!(:entry) { create :entry, name: "My Bracket", user: user, group_tournament: group_tournament }
    let!(:slot1) { create :slot, tournament: tournament, name: "Round 1 - Game 1", parent: slot5 }
    let!(:slot2) { create :slot, tournament: tournament, name: "Round 1 - Game 2", parent: slot5 }
    let!(:slot3) { create :slot, tournament: tournament, name: "Round 1 - Game 3" }
    let!(:slot5) { create :slot, tournament: tournament, name: "Round 2 - Game 1" }
    let!(:matchup1) { create :matchup, slot: slot1 }
    let!(:matchup2) { create :matchup, slot: slot2 }
    let!(:matchup1_opponent1) { create :opponent, matchup: matchup1, entrant: nadal_entrant, winner: true }
    let!(:matchup1_opponent2) { create :opponent, matchup: matchup1, entrant: federer_entrant, winner: false }
    let!(:matchup2_opponent1) { create :opponent, matchup: matchup2, entrant: del_potro_entrant, winner: false }
    let!(:matchup2_opponent2) { create :opponent, matchup: matchup2, entrant: murray_entrant, winner: true }
    let!(:pick_for_slot1) { create :pick, entry: entry, slot: slot1, entrant: nadal_entrant }
    let!(:pick_for_slot2) { create :pick, entry: entry, slot: slot2, entrant: del_potro_entrant }

    scenario "updating an entry with picks" do
      as_a_user_i_login user
      given_i_have_an_entry
      and_i_visit_a_group_tournament_page
      and_i_click_on_the_link_to_my_entry
      i_see_my_bracket
      and_i_see_winners
      and_i_see_losers
    end

    def i_see_my_bracket
      expect(page).to have_text "My Bracket Entry"
    end

    def and_i_see_winners
      within "section", text: "Round 2 - Game 1" do
        within ".entrant-name", text: "Rafael Nadal" do
          expect(page).to have_text "W"
        end
      end
    end

    def and_i_see_losers
      within "section", text: "Round 2 - Game 1" do
        within ".entrant-name", text: "Juan Del Potro" do
          expect(page).to have_text "X"
        end
      end
    end
  end

  def given_i_have_an_entry
    #no-op
  end

  def and_i_click_on_the_link_to_my_entry
    find("tr", text: entry.name).click_link("View")
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_a_group_tournament_page
    visit group_tournament_path group_tournament
  end
end
