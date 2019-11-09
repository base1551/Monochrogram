FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "テストユーザー#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :with_posts do
      transient do
        posts_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
