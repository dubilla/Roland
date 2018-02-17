class AddExternalIdToMatchups < ActiveRecord::Migration
  def change
    add_column :matchups, :external_id, :integer
  end
end
