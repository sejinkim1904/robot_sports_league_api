FactoryBot.define do
  factory :team do
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    team_name { Faker::Team.name }
  end
end
