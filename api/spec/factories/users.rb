FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'success@simulator.amazonses.com' }
  end
end