FactoryBot.define do
  factory :bot do
    name { Faker::Name.name }
    speed { rand(1..50) }
    strength { rand(1..50) }
    agility { rand(1..50) }
  end
end
