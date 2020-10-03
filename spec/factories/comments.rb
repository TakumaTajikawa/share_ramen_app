FactoryBot.define do
  factory :comment do
    content { '美味しそうですね' }
    association :post
    association :user
  end
end
