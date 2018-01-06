class AddOpponentToPick < ActiveRecord::Migration
  def change
    add_reference :picks, :opponent, index: true, foreign_key: true
  end
end
