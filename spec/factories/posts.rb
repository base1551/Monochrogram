FactoryBot.define do
  factory :post do
    caption { 'It so cool' }
    association :user

    trait :with_photos do
      transient do
        photos_count { 1 }
      end

      after(:create) do |post, evaluator|
        create_list(:photo, evaluator.photos_count, post: post)
      end
    end

    trait :with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end

    trait :with_likes do
      transient do
        likes_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:like, evaluator.likes_count, post: post)
      end
    end
  end
end
