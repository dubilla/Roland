class AddWinnerToOpponent < ActiveRecord::Migration
  def change
    add_column :opponents, :winner, :boolean
  end
end
