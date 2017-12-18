require "rails_helper"

RSpec.feature "Entries", type: :feature do
  let(:user) { create :user, email: 'jason.day@golf.com' }
  let(:group) { create :group, name: 'Pool' }
  let(:tournament) { create :tournament, name: 'Denver Open' }
  let(:group_tournament) { create :group_tournament, group: group, tournament: tournament }

  scenario do
    as_a_user_i_login user
    and_i_visit_a_group_tournament_page
    i_can_create_an_entry
    get_redirected_to_the_group_tournament_page
    and_see_my_entry_listed
    i_can_delete_my_entry
    and_i_no_longer_see_it
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_a_group_tournament_page
    visit group_tournament_path group_tournament
  end

  def i_can_create_an_entry
    click_link 'Create an entry'
    expect(page).to have_text 'Create Entry'
    fill_in 'Name', with: 'My entry'
    click_button 'Create Entry'
  end

  def get_redirected_to_the_group_tournament_page
    expect(page).to have_text 'Denver Open'
  end

  def and_see_my_entry_listed
    expect(page).to have_text 'My entry'
  end

  def i_can_delete_my_entry
    click_link 'Delete'
  end

  def and_i_no_longer_see_it
    expect(page).to have_text 'Denver Open'
    expect(page).to have_no_text 'My entry'
  end
end
