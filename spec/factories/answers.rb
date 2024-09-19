FactoryBot.define do
  factory :answer do
    evaluation { nil }
    question { nil }
    score { "9.99" }
    comment { "MyText" }
  end
end
