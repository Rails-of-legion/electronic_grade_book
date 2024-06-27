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
  
  # Создание пользователей-администраторов
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
  
