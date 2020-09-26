FactoryBot.define do
  factory :user do
    name { "山田太郎" }
    sequence(:email) { |n| "yamada#{n}@example.com" }
    password { "dot2s7bo2ze" }
  end
end
