FactoryBot.define do
  factory :critical_field do
    evaluation { nil }
    title { "MyString" }
    discount_percentage { "9.99" }
  end
end
