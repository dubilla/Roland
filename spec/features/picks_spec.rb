require "rails_helper"

RSpec.feature "Picks", type: :feature do
  let(:user) { create :user }
  let(:tournament) { create :tournament }
  let!(:opponent1) { create :opponent, tournament: tournament, name: "Bob" }
  let!(:opponent2) { create :opponent, tournament: tournament, name: "Carol" }
  let(:slot) { create :slot, tournament: tournament, name: "Slot 1" }
  let(:group) { create :group }
  let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }
  let(:entry) { create :entry, user: user, group_tournament: group_tournament, name: "My First" }
  let!(:pick) { create :pick, entry: entry, slot: slot }

  scenario "making a pick" do
    as_a_user_i_login user
    given_i_have_an_entry
    and_i_visit_my_entry_page
    i_can_pick_a_game
    make_a_pick
    and_see_the_pick_on_the_entry_page
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
    find("div", text: "Pick Slot 1").click_link "Make Pick"
    expect(page).to have_text "Pick for Slot 1"
  end

  def make_a_pick
    select "Carol", from: "Winner"
    click_button "Make Pick"
  end

  def and_see_the_pick_on_the_entry_page
    expect(page).to have_text "My First Entry"
    expect(page).to have_text "Pick: Carol"
  end
end
