FactoryBot.define do
  factory :comment do
    comment { 'I like it.' }
    association :user
    association :post
  end
end
