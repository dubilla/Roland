class AddSlotToMatchup < ActiveRecord::Migration
  def change
    add_reference :matchups, :slot, index: true, foriegn_key: true, null: false
  end
end
