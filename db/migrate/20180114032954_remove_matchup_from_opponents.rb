class RemoveMatchupFromOpponents < ActiveRecord::Migration
  def change
    remove_column :opponents, :matchup_id
  end
end
