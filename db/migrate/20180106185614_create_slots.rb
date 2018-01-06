class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.references :tournament
      t.timestamps
    end
  end
end
