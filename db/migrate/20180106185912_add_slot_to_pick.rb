class AddSlotToPick < ActiveRecord::Migration
  def change
    add_reference :picks, :slot, index: true, foreign_key: true
  end
end
