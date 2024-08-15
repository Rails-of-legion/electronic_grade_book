# spec/factories/notifications_users.rb
FactoryBot.define do
  factory :notifications_user do
    association :notification
    association :user
  end
end
