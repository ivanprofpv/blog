FactoryBot.define do
  factory :post do
    title { "TitlePost" }
    body { "BodyPost" }

    trait :invalid do
      title { nil }
      body { nil }
    end
  end
end
