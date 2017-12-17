class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_tournament
end
