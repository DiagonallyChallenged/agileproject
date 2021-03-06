FactoryBot.define do
  factory :piece do
  end

  factory :game do
    name { 'Awesome!' }
    association :white_player, factory: :user
  end

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { 'secretPassword' }
    password_confirmation { 'secretPassword' }
  end
end
