class ChangeOpponents < ActiveRecord::Migration
  def change
    rename_table :opponents, :entrants
    rename_table :matchup_opponents, :opponents
    rename_column :picks, :opponent_id, :entrant_id
    rename_column :opponents, :opponent_id, :entrant_id
  end
end
