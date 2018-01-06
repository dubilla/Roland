class Pick < ActiveRecord::Base
  belongs_to :entry
  belongs_to :slot
end
