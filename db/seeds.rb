require 'faker'

Faker::UniqueGenerator.clear

# Создание ролей
puts "Создание ролей..."
Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')
puts "Созданы роли: #{Role.pluck(:name)}"

# Создание пользователя-администратора
puts "Создание пользователей-администраторов..."
2.times do |_i|
  admin = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.middle_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    status: true,
    date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 50)
  )
  admin.add_role(:admin)
  puts "Создан пользователь-администратор: #{admin.email}"
end

# Создание преподавателей
puts "Создание преподавателей..."
50.times do |_i|
  teacher = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.middle_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    status: true,
    date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 40)
  )
  teacher.add_role(:teacher)
  puts "Создан преподаватель: #{teacher.email}"
end

# Создание семестров
puts "Создание семестров..."
20.times do |i|
  semester = Semester.create!(
    name: "Семестр #{i + 1}",
    start_date: Faker::Date.between(from: 2.years.ago, to: Time.zone.today),
    end_date: Faker::Date.between(from: Time.zone.today, to: 2.years.from_now)
  )
  puts "Создан семестр: #{semester.name}"
end

# Создание групп с уникальными специализациями и предметами
puts "Создание групп, специализаций и предметов..."
groups = 50.times.map do |i|
  specialization = Specialization.create!(name: "Специализация #{i + 1}")
  puts "Создана специализация: #{specialization.name}"

  gcount = 0

  group = Group.create!(
    name: "Группа #{gcount + 1}",
    curator: User.with_role(:teacher).sample,
    specialization: specialization
  )
  puts "Создана группа: #{group.name} со специализацией #{specialization.name}"

  # Создание уникальных предметов для этой специализации
  20.times do |j|
    subject = Subject.create!(
      name: "#{specialization.name} Предмет #{j + 1}",
      description: Faker::Lorem.paragraph
    )
    SpecialitiesSubject.create!(specialization: specialization, subject: subject)
    puts "Создан предмет: #{subject.name} для специализации #{specialization.name}"
  end

  group
end

# Создание студентов и зачетных книжек
puts "Создание студентов и зачетных книжек..."
50.times do |_i|
  group = groups.sample
  student = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.middle_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    status: [true, false].sample,
    date_of_birth: Faker::Date.birthday(min_age: 17, max_age: 23)
  )
  student.add_role(:student)
  puts "Создан студент: #{student.email}"

  record_book = RecordBook.create!(
    custom_number: Faker::Code.npi,
    user: student,
    specialization: group.specialization,
    group: group
  )
  puts "Создана зачетная книжка для студента #{student.email} из группы #{group.name}"

  # Создание оценок для студента
  record_book.specialization.subjects.each do |subject|
    grade_value = rand(2..5)
    grade = Grade.create!(
      grade: grade_value,
      subject: subject,
      record_book: record_book,
      date: Date.today
    )

    puts "Создана оценка #{grade.grade} для студента #{student.email} по предмету #{subject.name}"
  end
end

# Создание уведомлений
puts "Создание уведомлений..."
notification_data = [
  { message: "Добро пожаловать в приложение!", date: Time.zone.now },
  { message: "Доступны новые функции!", date: 1.day.ago },
  { message: "Не забудьте обновить профиль!", date: 2.days.ago }
]
notification_data.each do |data|
  Notification.create!(data)
end

# Связывание уведомлений с пользователями
puts "Связывание уведомлений с пользователями..."
users = User.all
notifications = Notification.all

notifications.each do |notification|
  users.each do |user|
    NotificationsUser.create!(
      notification: notification,
      user: user,
      status: false
    )
  end
end

# Создание промежуточных аттестаций
puts "Создание промежуточных аттестаций..."
100.times do
  intermediate_attestation = IntermediateAttestation.create!(
    name: Faker::Lorem.sentence(word_count: 3),
    assessment_type: ["Тест", "Эссе", "Практика"].sample,
    subject: Subject.all.sample,
    teacher: User.with_role(:teacher).sample,
    date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  )
  puts "Создана промежуточная аттестация: #{intermediate_attestation.name}"

  # Привязка промежуточной аттестации к случайной группе
  group = Group.all.sample
  GroupsIntermediateAttestation.create!(
    group: group,
    intermediate_attestation: intermediate_attestation
  )
  puts "Привязана промежуточная аттестация #{intermediate_attestation.name} к группе #{group.name}"
end

puts "Сиды успешно созданы!"
