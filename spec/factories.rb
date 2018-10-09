FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "123456" }
  end
end

FactoryBot.define do
  factory :currency do
    # Keep in sync with: app/models/currency.rb
    code { %w[ SEK EUR GBP USD].sample }
  end
end

FactoryBot.define do
  factory :item do
    name { "FooBar" }
    description { "Oh my what a fantastic item" }
    start_price { 300 }

    association :user, factory: :user
    association :currency, factory: :currency
  end
end
