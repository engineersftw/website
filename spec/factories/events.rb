FactoryGirl.define do
  factory :event do
    webuild_id { Faker::Number.number(10) }
    group_id { Faker::Number.number(10) }
    platform "facebook"

    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.street_address }
    url { Faker::Internet.url }

    group_name { Faker::Lorem.sentence }
    group_url { Faker::Internet.url }
    start_time { Faker::Time.forward(1, :morning) }
    end_time { Faker::Time.forward(1, :evening) }

    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
