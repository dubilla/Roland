require "rails_helper"

RSpec.feature "Groups", type: :feature do
  let(:user) { create :user, email: 'jason.day@golf.com' }
  let(:tournament) { create :tournament }

  scenario do
    as_a_user_i_login user
    and_i_visit_the_groups_page
    i_can_see_a_list_of_groups
    i_can_create_a_group
    and_see_the_group_page
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_the_groups_page
    visit groups_path
  end

  def i_can_see_a_list_of_groups
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
    expect(page).to have_text 'jason.day@golf.com'
  end
end
