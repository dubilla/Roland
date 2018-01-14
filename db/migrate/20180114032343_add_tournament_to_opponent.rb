class AddTournamentToOpponent < ActiveRecord::Migration
  def change
    add_reference :opponents, :tournament, index: true, foreign_key: true
  end
end
