FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'asdfjkl'
  end

  factory :group do
    name 'Group Name'
  end

  factory :tournament do
    name 'The French Open'
  end

  factory :group_tournament
end
