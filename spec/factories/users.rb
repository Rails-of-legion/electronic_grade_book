FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    status { true }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }

    after(:create) do |user, evaluator|
      role = create(:role, evaluator.role_name)
      user.roles << role
    end

    transient do
      role_name { 'student' }
    end

    trait :as_teacher do
      role_name { 'teacher' }
    end
  end
end
