class RemoveNameFromOpponent < ActiveRecord::Migration
  def change
    remove_column :opponents, :name
  end
end
