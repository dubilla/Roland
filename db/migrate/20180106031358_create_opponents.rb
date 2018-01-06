class CreateOpponents < ActiveRecord::Migration
  def change
    create_table :opponents do |t|
      t.string :name
      t.references :tournament, index: true, foreign_key: true, null: false
    end
  end
end
