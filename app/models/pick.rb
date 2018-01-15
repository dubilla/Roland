class Pick < ActiveRecord::Base
  belongs_to :entry
  belongs_to :slot
  belongs_to :entrant

  delegate :name, to: :slot, prefix: true
  delegate :name, to: :entrant, prefix: true
end
