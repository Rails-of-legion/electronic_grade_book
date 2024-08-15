FactoryBot.define do
  factory :notification do
    message { Faker::Lorem.sentence }
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    
    # Создание связанного пользователя
    after(:create) do |notification|
      user = create(:user)
      notification.users << user  
    end
    after(:build) do |notification|
      notification.users << build(:user) if notification.users.empty?
    end
  end
end