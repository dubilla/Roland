class AddAncestryToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :ancestry, :string
    add_index :slots, :ancestry
  end
end
