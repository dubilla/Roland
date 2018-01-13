class AddPlayerToOpponents < ActiveRecord::Migration
  def change
    add_reference :opponents, :player, index: true, foreign_key: true, null: false
  end
end
