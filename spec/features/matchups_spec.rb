require "rails_helper"

RSpec.feature "Matchups", type: :feature do
  context "i am an admin" do
    let(:admin) { create :admin, email: "admin@golf.com" }
    scenario "scoring a matchup" do
      as_a_user_i_login admin
      and_i_visit_the_tournaments_page
      #and_i_click_on_a_tournament
      #and_i_see_matchups
      #and_i_visit_a_matchup
      #i_can_score_it
      #and_i_see_it_scored
    end

    def as_a_user_i_login user
      login_as(user, scope: :user)
    end

    def and_i_visit_the_tournaments_page
      visit tournaments_path
    end
  end
end
