class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.references :group, index: true, null: false, foreign_key: true
      t.references :user, index: true, null: false, foreign_key: true
      t.index [:group_id, :user_id]
      t.index [:user_id, :group_id]
    end
  end
end
