FactoryBot.define do
  factory :track do
    title { Faker::GreekPhilosophers.quote }
    genre { 'rock' }
    source_link { Faker::Internet.url('youtube.com') }
    library
    artist
    source
  end
end
