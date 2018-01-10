class RemoveOpponentFromTournament < ActiveRecord::Migration
  def change
    remove_reference :opponents, :tournament, index: true, foreign_key: true
  end
end
