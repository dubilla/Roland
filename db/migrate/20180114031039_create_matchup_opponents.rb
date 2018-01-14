class CreateMatchupOpponents < ActiveRecord::Migration
  def change
    create_table :matchup_opponents do |t|
      t.references :matchup, index: true, null: false
      t.references :opponent, index: true, null: false

      t.timestamps
    end
  end
end
