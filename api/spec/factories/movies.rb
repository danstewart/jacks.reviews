FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    tmdb_id { Faker::Number.number(5) }
  end
end