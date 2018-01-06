class Pick < ActiveRecord::Base
  belongs_to :entry
  belongs_to :slot
  belongs_to :opponent

  delegate :name, to: :slot, prefix: true
end
