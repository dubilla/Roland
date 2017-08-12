class CreateJoinTableGroupTournament < ActiveRecord::Migration
  def change
    create_join_table :groups, :tournaments do |t|
       t.index [:group_id, :tournament_id]
       t.index [:tournament_id, :group_id]
    end
  end
end
