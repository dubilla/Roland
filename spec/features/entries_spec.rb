require "rails_helper"

RSpec.feature "Entries", type: :feature do
  let(:user) { create :user, email: 'jason.day@golf.com' }
  let(:group) { create :group, name: 'Pool' }
  let(:tournament) { create :tournament, name: 'Denver Open' }
  let!(:slot) { create :slot, tournament: tournament }
  let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }

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

  context "with an existing entry" do
    let!(:entry) { create :entry, name: "My Bracket", user: user, group_tournament: group_tournament }
    let!(:slot1) { create :slot, tournament: tournament }
    let!(:slot2) { create :slot, tournament: tournament }
    let!(:pick_for_slot1) { create :pick, entry: entry, slot: slot1 }
    let!(:pick_for_slot2) { create :pick, entry: entry, slot: slot2 }

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
      expect(page).to have_text "Make Pick", count: 2
    end
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_a_group_tournament_page
    visit group_tournament_path group_tournament
  end
end
