FactoryBot.define do
  factory :evaluation do
    employee { nil }
    monitor { nil }
    date { "2024-09-19 15:20:31" }
    comment { "MyText" }
    total_score { "9.99" }
  end
end
