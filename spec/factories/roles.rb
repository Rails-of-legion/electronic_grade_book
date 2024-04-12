FactoryBot.define do
  factory :role do
    trait :student do
      name { 'student' }
    end

    trait :admin do
      name { 'admin' }
    end

    trait :teacher do
      name { 'teacher' }
    end
  end
end
