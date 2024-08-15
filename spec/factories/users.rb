FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    middle_name { Faker::Name.middle_name }
    phone_number { "+375#{['29', '44', '25', '33'].sample}#{Faker::Number.number(digits: 7)}" }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    status { true }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }

    transient do
      role_name { 'student' }
    end

    after(:create) do |user, evaluator|
      role = create(:role, evaluator.role_name)
      user.roles << role
    end

    trait :as_student do
      role_name { 'student' }
    end

    trait :as_teacher do
      role_name { 'teacher' }
    end
    trait :as_admin do
      role_name { 'admin' }
    end
  end
end
