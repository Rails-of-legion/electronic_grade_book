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
#Создание пользователей-администраторов

puts "Создание пользователей-администраторов..."
admin1 = User.create!(
first_name: "Юрий",
last_name: "Юрьевич",
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
first_name: "Петр",
last_name: "Петров",
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
#Создание преподавателей с ролью "teacher"

puts "Создание преподавателей..."
teachers = 1.times.map do
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
middle_name = Faker::Name.middle_name
middle_name = Faker::Name.middle_name while middle_name.length < 3 # Проверяем длину отчества

teacher = User.create!(
first_name: first_name,
last_name: last_name,
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
#Создание студентов и зачетных книжек

puts "Создание студентов и зачетных книжек..."
1.times do
student = User.create!(
first_name: Faker::Name.first_name,
last_name: Faker::Name.last_name,
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

end
