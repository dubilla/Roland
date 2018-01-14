FactoryBot.define do
  factory :user do
    email 'test@test.com'
    password 'asdfjkl'
  end

  factory :admin, class: User do
    admin true
    email 'admin@test.com'
    password 'asdfjkl'
  end

  factory :group do
    name 'Group Name'
  end

  factory :tournament do
    name 'The French Open'
  end

  factory :group_tournament

  factory :entry

  factory :slot

  factory :pick

  factory :opponent

  factory :matchup
end
