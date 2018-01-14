require "rails_helper"

RSpec.feature "Groups", type: :feature do
  let(:user) { create :user, email: "jason.day@golf.com" }
  let(:tournament) { create :tournament }

  context "i am a non-admin" do
    let(:user) { create :user, email: 'jason.day@golf.com' }
    let!(:group) { create :group, name: "Open Group" }

    scenario "viewing groups" do
      as_a_user_i_login user
      and_i_visit_the_groups_page
      i_can_see_the_groups
      and_i_cannot_create_a_group
    end

    def i_can_see_the_groups
      expect(page).to have_text "Open Group"
    end

    def and_i_cannot_create_a_group
      expect(page).to have_no_link "Create a group"
    end
  end

  context "i am an admin and there are no groups" do
    let(:admin) { create :admin, email: "admin@golf.com" }
    scenario "creating a group" do
      as_a_user_i_login admin
      and_i_visit_the_groups_page
      i_see_there_are_no_groups
      i_can_create_a_group
      and_see_the_group_page
    end

    def i_see_there_are_no_groups
      expect(page).to have_text 'Groups'
      expect(page).to have_text 'There are no groups'
    end

    def i_can_create_a_group
      click_link 'Create a group'
      expect(page).to have_text 'Create Group'
      fill_in 'Name', with: 'Pool'
      click_button 'Create Group'
    end

    def and_see_the_group_page
      expect(page).to have_text 'Pool'
      expect(page).to have_text 'admin@golf.com'
    end
  end

  context "there are groups" do
    let(:group) { create :group, name: "Open Group" }

    scenario "joining a group" do
      as_a_user_i_login user
      and_i_visit_a_group_page
      i_can_join_a_group
    end

    def and_i_visit_a_group_page
      visit group_path group
    end

    def i_can_join_a_group
      click_link "Join Group"
      expect(page).to have_text "Join Open Group"
      click_button "Join"
    end

    def group_memberships
      find("div", text: "Members")
    end
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_the_groups_page
    visit groups_path
  end
end
