class Player < ActiveRecord::Base
  has_many :opponents

  validates :external_id, uniqueness: true, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
