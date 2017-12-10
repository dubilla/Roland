class CreateGroupTournaments < ActiveRecord::Migration
  def change
    create_table :group_tournaments do |t|
      t.references  :group, index: true, null: false, foreign_key: true
      t.references :user, index: true, null: false, foregin_key: true
    end
  end
end
