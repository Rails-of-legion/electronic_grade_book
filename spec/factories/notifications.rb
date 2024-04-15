FactoryBot.define do
  factory :notification do
    user { nil }
    message { "MyText" }
    date { "2024-04-15 19:09:18" }
    read_status { "MyString" }
  end
end
