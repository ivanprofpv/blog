FactoryBot.define do
  factory :comment do
    body { "comment" }

    trait :invalid do
      body { nil }
    end

  end
end
