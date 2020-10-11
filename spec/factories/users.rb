FactoryBot.define do
  factory :user, aliases: [:follower, :following] do
    name { "山田太郎" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "dot2s7bo2ze" }
  end
end
