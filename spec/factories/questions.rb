FactoryBot.define do
  factory :question do
    evaluation { nil }
    title { "MyString" }
    description { "MyText" }
    score { "9.99" }
  end
end
