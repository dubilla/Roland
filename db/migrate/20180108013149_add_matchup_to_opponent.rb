class AddMatchupToOpponent < ActiveRecord::Migration
  def change
    add_reference :opponents, :matchup, index: true, foreign_key: true, null: false
  end
end
