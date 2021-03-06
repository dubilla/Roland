class Entrant < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :player
  has_many :picks
  has_many :opponents, inverse_of: :opponent
  has_many :matchups, through: :opponents

  delegate :name, to: :player, prefix: true
  delegate :name, to: :tournament, prefix: true

  alias_attribute :name, :player_name
end
