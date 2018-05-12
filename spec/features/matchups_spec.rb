require "rails_helper"

RSpec.feature "Matchups", type: :feature do
  context "i am an admin" do
    let(:admin) { create :admin, email: "admin@golf.com" }
    let(:tournament) { create :tournament, name: "French Open" }
    let(:slot) { create :slot, tournament: tournament }
    let(:matchup) { create :matchup, slot: slot }
    let(:steffi) { create :player, first_name: "Steffi", last_name: "Graff" }
    let(:venus) { create :player, first_name: "Venus", last_name: "Williams" }
    let(:entrant1) { create :entrant, player: steffi }
    let(:entrant2) { create :entrant, player: venus }
    let!(:opponent1) { create :opponent, matchup: matchup, entrant: entrant1 }
    let!(:opponent2) { create :opponent, matchup: matchup, entrant: entrant2 }
    scenario "scoring a matchup" do
      as_a_user_i_login admin
      and_i_visit_the_tournaments_page
      and_i_click_on_a_tournament_link
      i_see_a_list_of_matchups
      and_i_click_on_a_matchup
      #i_can_score_it
      #and_i_see_it_scored
    end

    def as_a_user_i_login user
      login_as(user, scope: :user)
    end

    def and_i_visit_the_tournaments_page
      visit tournaments_path
    end

    def and_i_click_on_a_tournament_link
      click_link "French Open"
    end

    def i_see_a_list_of_matchups
      expect(page).to have_text "Steffi Graff v Venus Williams"
    end

    def and_i_click_on_a_matchup
      click_link "Steffi Graff v Venus Williams"
    end
  end
end
