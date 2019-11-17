FactoryBot.define do
  factory :comment do
    comment { 'I like it.' }
    association :post
    association :user
    # user { post.user }
  end
end
