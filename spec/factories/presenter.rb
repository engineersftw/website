FactoryGirl.define do
  factory :presenter do
    name { Faker::Name.name }

    trait :with_twitter do
      twitter { Faker::Internet.user_name }
    end

    trait :with_email do
      email { Faker::Internet.email }
    end

    trait :with_avatar_url do
      avatar_url { Faker::Avatar.image }
    end
  end
end
