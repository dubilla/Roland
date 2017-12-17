class AddTournamentToGroupTournament < ActiveRecord::Migration
  def change
    add_reference :group_tournaments, :tournament, foreign_key: true, index: true
    remove_reference :group_tournaments, :user
  end
end
