class DropGroupsTournaments < ActiveRecord::Migration
  def change
    drop_table :groups_tournaments
  end
end
