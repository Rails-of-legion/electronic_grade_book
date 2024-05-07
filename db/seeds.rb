require 'faker'

Faker::UniqueGenerator.clear

# Создание ролей
Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')
Rails.logger.debug { "Созданы роли: #{Role.pluck(:name)}" }

# Создание пользователя-администратора
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
Rails.logger.debug { "Создан пользователь-администратор: #{admin.email}" }

# Создание преподавателей
2.times do |_i|
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
  Rails.logger.debug { "Создан преподаватель: #{teacher.email}" }
end

# Создание семестров
3.times do |i|
  semester = Semester.create!(
    name: "Семестр #{i + 1}",
    start_date: Faker::Date.between(from: 2.years.ago, to: Time.zone.today),
    end_date: Faker::Date.between(from: Time.zone.today, to: 2.years.from_now)
  )
  Rails.logger.debug { "Создан семестр: #{semester.name}" }
end

# Создание групп с уникальными специализациями и предметами
def create_group_with_specialization_and_subjects
  specialization_name = Faker::Educator.unique.subject
  specialization = Specialization.create!(name: specialization_name)
  Rails.logger.debug { "Создана специализация: #{specialization.name}" }

  group = Group.create!(
    name: Faker::Educator.unique.secondary_school,
    curator: User.with_role(:teacher).sample,
    specialization: specialization
  )
  Rails.logger.debug { "Создана группа: #{group.name} со специализацией #{specialization.name}" }

  # Создание уникальных предметов для этой специализации
  subjects_count = 4
  created_subjects = 0
  while created_subjects < subjects_count
    subject_name = Faker::Educator.subject 
    if Subject.where(name: subject_name).empty?
      subject = Subject.create!(
        name: subject_name,
        description: Faker::Lorem.paragraph,
        semester: Semester.all.sample
      )
      SpecialitiesSubject.create!(specialization: specialization, subject: subject)
      Rails.logger.debug { "Создан предмет: #{subject.name} для специализации #{specialization.name}" }
      created_subjects += 1
    end
  end

  group
end

groups = 5.times.map { create_group_with_specialization_and_subjects }

# Создание студентов и зачетных книжек
20.times do |_i|
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
  Rails.logger.debug { "Создан студент: #{student.email}" }

  rb = RecordBook.create!(
    custom_number: Faker::Code.npi,
    user: student,
    specialization: group.specialization, 
    group: group
  )
  Rails.logger.debug { "Создана зачетная книжка для студента #{student.email} из группы #{group.name}" }

  grade_value = rand(2..5)

# Выберите случайного студента
student = User.with_role(:student).sample

# Найдите зачетную книжку студента для его специальности
record_book = student.record_book

# Выберите предмет, который относится к специальности студента
subject = record_book.specialization.subjects.sample

# Создайте оценку
grade = Grade.create!(
  grade: grade_value,
  subject: subject,
  record_book: record_book,
  date: Date.today
)

Rails.logger.debug { "Создана оценка #{grade.grade} для студента #{student.email} по предмету #{subject.name}" }
end

notification_data = [
  { message: "Добро пожаловать в приложение!", date: Time.zone.now },
  { message: "Доступны новые функции!", date: 1.day.ago },
  { message: "Не забудьте обновить профиль!", date: 2.days.ago }
]

notification_data.each do |data|
  Notification.create!(data)
end

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

puts "Сиды успешно созданы!"