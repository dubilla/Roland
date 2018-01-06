class CreateMatchup < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.references :tournament
      t.timestamps
    end
  end
end
