

puts "Создание ролей..."
Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')
puts "Созданы роли: #{Role.pluck(:name)}"

# Создание пользователей-администраторов
puts "Создание пользователей-администраторов..."
admin1 = User.create!(
  first_name: "Юрий",
  last_name: "Юрьевич",
  middle_name: "Королев",
  email: 'admin1@example.com',
  password: 'password',
  password_confirmation: 'password',
  status: true,
)
admin1.add_role(:admin)
puts "Создан пользователь-администратор: #{admin1.email}"

admin2 = User.create!(
  first_name: "Петр",
  last_name: "Петров",
  middle_name: "Петрович",
  email: 'admin2@example.com',
  password: 'password',
  password_confirmation: 'password',
  status: true,
)
admin2.add_role(:admin)
puts "Создан пользователь-администратор: #{admin2.email}"





=begin
require 'faker'

def generate_phone_number(codes, prefixes)
  "#{codes.sample}#{prefixes.sample}#{rand.to_s[2..8]}"
end

codes = ['+375', '80']
prefixes = ['29', '44', '25', '33']

puts "Создание ролей..."
Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')
puts "Созданы роли: #{Role.pluck(:name)}"

# Создание специализаций
puts "Создание специализаций..."
specializations = []
3.times do |i|
  specialization = Specialization.find_or_create_by!(name: "Специализация #{i + 1}")
  specializations << specialization
end
puts "Созданы специализации: #{Specialization.pluck(:name)}"

# Создание предметов для каждой специализации
puts "Создание предметов для каждой специализации..."
subjects_data = [
  { name: "Математика", description: "Основы математики" },
  { name: "Физика", description: "Основы физики" },
  { name: "Литература", description: "Классическая русская литература" },
]

# Создание пользователей-администраторов
puts "Создание пользователей-администраторов..."
admin1 = User.create!(
  last_name: "Юрьевич",
  first_name: "Юрий",
  middle_name: "Королев",
  phone_number: generate_phone_number(codes, prefixes),
  email: 'admin1@example.com',
  password: 'password',
  password_confirmation: 'password',
  status: true,
  date_of_birth: Date.new(1980, 1, 1)
)
admin1.add_role(:admin)
puts "Создан пользователь-администратор: #{admin1.email}"

admin2 = User.create!(
  last_name: "Петров",
  first_name: "Петр",
  middle_name: "Петрович",
  phone_number: generate_phone_number(codes, prefixes),
  email: 'admin2@example.com',
  password: 'password',
  password_confirmation: 'password',
  status: true,
  date_of_birth: Date.new(1982, 3, 15)
)
admin2.add_role(:admin)
puts "Создан пользователь-администратор: #{admin2.email}"

#  Создание преподавателей с ролью "teacher"
puts "Создание преподавателей..."
teachers = 5.times.map do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  middle_name = Faker::Name.middle_name
  middle_name = Faker::Name.middle_name while middle_name.length < 3 # Проверяем длину отчества

  teacher = User.create!(
    last_name: last_name,
    first_name: first_name,
    middle_name: middle_name,
    phone_number: generate_phone_number(codes, prefixes),
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    status: true,
    date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65)
  )
  teacher.add_role(:teacher)
  puts "Создан преподаватель: #{teacher.email}"
  teacher
end

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

puts "Создание групп..."
groups = []
3.times do |i|
  2.times do |j|
    specialization = specializations.sample
    curator = teachers.sample

    group = Group.create!(
      name: "Группа #{('A'.ord + j).chr}#{i + 1}",
      specialization: specialization,
      curator: curator,
      form_of_education: "Очная" # или заочная, в зависимости от ваших требований
    )
    puts "Создана группа: #{group.name} со специализацией #{group.specialization.name} и куратором #{curator.last_name} #{curator.first_name}"
    groups << group
  end
end

# Создание студентов и зачетных книжек
puts "Создание студентов и зачетных книжек..."
10.times do
  group = groups.sample
  student = User.create!(
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    middle_name: Faker::Name.middle_name,
    phone_number: generate_phone_number(codes, prefixes),
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


puts "Создание семестров..."
3.times do |i|
  semester = Semester.create!(
    name: "Семестр #{i + 1}",
    start_date: Time.zone.today - (i + 1).years,
    end_date: Time.zone.today + (i + 1).months
  )
  puts "Создан семестр: #{semester.name}"
end
=end
