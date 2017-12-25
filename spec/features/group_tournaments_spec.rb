require "rails_helper"

RSpec.feature "Group Tournaments", type: :feature do
  let(:user) { create :user }
  let(:group) { create :group }
  let!(:tournament) { create :tournament, name: "The French Open", start_date: Date.tomorrow }

  scenario do
    as_a_user_i_login user
    and_i_visit_a_group_page
    i_can_see_an_upcoming_tournament
  end

  def as_a_user_i_login user
    login_as(user, scope: :user)
  end

  def and_i_visit_a_group_page
    visit group_path group
  end

  def i_can_see_an_upcoming_tournament
    expect(page).to have_text 'The French Open'
    click_link 'Add tournament to group'
  end
end
