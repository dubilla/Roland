class AddLockedToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :locked, :boolean
  end
end
