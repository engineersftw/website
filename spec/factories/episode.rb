FactoryBot.define do
  factory :episode do
    video_id { SecureRandom::hex(10) }
    title { Faker::Name.name }
    published_at { DateTime.now }
    image1 { Faker::Avatar.image }
    image2 { Faker::Avatar.image }
    image3 { Faker::Avatar.image }
    description { Faker::Lorem.paragraph(2) }
  end
end
