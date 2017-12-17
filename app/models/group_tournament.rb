class GroupTournament < ActiveRecord::Base
  has_many :entries
  belongs_to :group
  belongs_to :tournament

  delegate :name, to: :tournament, prefix: true
end
