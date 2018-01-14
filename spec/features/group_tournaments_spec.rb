require "rails_helper"

RSpec.feature "Group Tournaments", type: :feature do
  let(:user) { create :user }
  let(:group) { create :group }
  let!(:tournament) { create :tournament, name: "The French Open", start_date: Date.tomorrow }

  scenario do
    as_a_user_i_login user
    and_i_visit_a_group_page
    i_can_create_an_upcoming_tournament
    and_i_can_visit_that_group_tournament_page
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_a_group_page
    visit group_path group
  end

  def i_can_create_an_upcoming_tournament
    within available_tournaments_card do
      expect(page).to have_text "The French Open"
      click_link 'Add tournament to group'
    end
    within tournaments_card do
      expect(page).to have_text "The French Open"
    end
  end

  def and_i_can_visit_that_group_tournament_page
    click_link "The French Open"
    expect(page).to have_text "The French Open"
    expect(page).to have_text "Entries"
  end

  private

  def available_tournaments_card
    find("div", text: "Available Tournaments")
  end

  def tournaments_card
    find("div", text: "Tournaments", match: :prefer_exact)
  end
end
