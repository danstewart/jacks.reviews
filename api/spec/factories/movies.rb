FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    tmdb_id { Faker::Number.number(digits: 5) }
  end
end