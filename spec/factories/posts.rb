FactoryBot.define do
  factory :post do
    store { "麺屋山田屋" }
    prefecture { "東京都" }
    genre { "醤油" }
    ramen { "中華そば" }
    impression { "美味しかった" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/uploads/post/image/20/bunnryuu.jpg')) }
    association :user
  end
end