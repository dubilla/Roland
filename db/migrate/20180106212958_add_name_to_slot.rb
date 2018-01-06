class AddNameToSlot < ActiveRecord::Migration
  def change
    add_column :slots, :name, :string
  end
end
