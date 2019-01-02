FactoryBot.define do
  factory :artist do
    fullname { Faker::Artist.name }
  end
end
