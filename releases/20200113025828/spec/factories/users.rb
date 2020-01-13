FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "sample#{n}" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    password { '123456' }

    trait :invalid do
      name     { 'users' } # 既存のルーティング("/users")と重複するユーザーネーム
      email    { 'user@invalid' }
      password { 'bar' }
    end

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
