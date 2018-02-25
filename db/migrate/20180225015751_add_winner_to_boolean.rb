class AddWinnerToBoolean < ActiveRecord::Migration
  def change
    add_column :picks, :winner, :boolean
  end
end
