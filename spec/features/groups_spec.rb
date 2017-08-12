require "rails_helper"

RSpec.feature "Groups", type: :feature do
  let(:user) { create :user }
  let(:tournament) { create :tournament }

  scenario do
    as_a_user_i_login user
    and_i_visit_the_groups_page
    i_can_see_a_list_of_groups
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
end
