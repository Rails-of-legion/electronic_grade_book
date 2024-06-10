require 'faker'

puts "Создание ролей..."
Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')
puts "Созданы роли: #{Role.pluck(:name)}"

# Создание специализаций
puts "Создание специализаций..."
specializations = []
5.times do |i|
  specialization = Specialization.create!(name: "Специализация #{i + 1}")
  specializations << specialization
end
puts "Созданы специализации: #{Specialization.pluck(:name)}"

# Создание предметов для каждой специализации
puts "Создание предметов для каждой специализации..."
subjects_data = [
  { name: "Математика", description: "Основы математики" },
  { name: "Физика", description: "Основы физики" },
  { name: "Литература", description: "Классическая русская литература" },
  { name: "История", description: "История России" },
  { name: "Химия", description: "Основы химии" },
  { name: "Биология", description: "Основы биологии" },
  { name: "География", description: "География мира" },
  { name: "Информатика", description: "Основы информатики" },
  { name: "Иностранный язык", description: "Английский язык" },
  { name: "Искусство", description: "Искусство и культура" }
]

specializations.each do |specialization|
  subjects_data.each do |subject_data|
    subject = Subject.create!(
      name: "#{subject_data[:name]} #{specialization.name}",
      description: "#{subject_data[:description]} для #{specialization.name}"
    )
    SpecialitiesSubject.create!(specialization: specialization, subject: subject)
    puts "Создан предмет: #{subject.name} для специализации #{specialization.name}"
  end
end

# Создание групп
puts "Создание групп..."
groups = []
5.times do |i|
  4.times do |j|
    group = Group.create!(
      name: "Группа #{('A'.ord + j).chr}",
      specialization: specializations.sample
    )
    puts "Создана группа: #{group.name} со специализацией #{group.specialization.name}"
    groups << group
  end
end

# Создание пользователей-администраторов
puts "Создание пользователей-администраторов..."
admin1 = User.create!(
  first_name: "Иван",
  last_name: "Иванов",
  middle_name: "Иванович",
  phone_number: '+79991234567',
  email: 'admin1@example.com',
  password: 'password',
  password_confirmation: 'password',
  status: true,
  date_of_birth: Date.new(1980, 1, 1)
)
admin1.add_role(:admin)
puts "Создан пользователь-администратор: #{admin1.email}"

admin2 = User.create!(
  first_name: "Петр",
  last_name: "Петров",
  middle_name: "Петрович",
  phone_number: '+79991234568',
  email: 'admin2@example.com',
  password: 'password',
  password_confirmation: 'password',
  status: true,
  date_of_birth: Date.new(1982, 3, 15)
)
admin2.add_role(:admin)
puts "Создан пользователь-администратор: #{admin2.email}"

# Создание преподавателей
puts "Создание преподавателей..."
20.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  middle_name = Faker::Name.middle_name
  middle_name = Faker::Name.middle_name while middle_name.length < 3 # Проверяем длину отчества

  teacher = User.create!(
    first_name: first_name,
    last_name: last_name,
    middle_name: middle_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    status: true,
    date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65)
  )
  teacher.add_role(:teacher)
  puts "Создан преподаватель: #{teacher.email}"
end

# Создание студентов и зачетных книжек
puts "Создание студентов и зачетных книжек..."
100.times do
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
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 25)
  )
  student.add_role(:student)
  puts "Создан студент: #{student.email}"

  # Создание зачетной книжки для студента
  record_book = RecordBook.create!(
    custom_number: Faker::Number.unique.number(digits: 6),
    user: student,
    specialization: group.specialization,
    group: group
  )
  puts "Создана зачетная книжка для студента #{student.email} из группы #{group.name}"
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
puts "Уведомления успешно созданы!"

puts "Создание семестров..."
5.times do |i|
  semester = Semester.create!(
    name: "Семестр #{i + 1}",
    start_date: Time.zone.today - (i + 1).years,
    end_date: Time.zone.today + (i + 1).months
  )
  puts "Создан семестр: #{semester.name}"
end

# Создание промежуточных аттестаций
puts "Создание промежуточных аттестаций..."
subjects = Subject.all
teachers = User.with_role(:teacher)
assessment_types = ["Тест", "Эссе", "Практика"]

30.times do |i|
  subject = subjects.sample
  teacher = teachers.sample
  assessment_type = assessment_types.sample

  intermediate_attestation = IntermediateAttestation.create!(
    name: "#{i + 1}, #{subject.name}, #{assessment_type}",
    assessment_type: assessment_type,
    subject: subject,
    teacher: teacher,
    date: Time.zone.today + (i + 1).weeks
  )

  puts "Создана промежуточная аттестация: #{intermediate_attestation.name}"
end

# Создание оценок для студентов
puts "Создание оценок для студентов..."
RecordBook.includes(:specialization).find_each do |record_book|
  record_book.specialization.subjects.each do |subject|
    intermediate_attestation = IntermediateAttestation.find_by(subject: subject)
    next unless intermediate_attestation # Пропускаем, если нет промежуточной аттестации для предмета

    grade_value = rand(2..5)
    grade = Grade.create!(
      grade: grade_value,
      subject: intermediate_attestation,
      record_book: record_book,
      date: Date.today
    )

    puts "Создана оценка #{grade.grade} для студента #{record_book.user.email} по предмету #{subject.name}"
  end
end
