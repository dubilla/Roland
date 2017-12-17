class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :group_tournament, index: true, null: false, foreign_key: true
      t.references :user, index: true, null: false, foreign_key: true
      t.string :name
    end
  end
end
