FactoryBot.define do
  factory :playlist do
    title { Faker::Music.album }
    library
  end
end
