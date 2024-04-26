require 'faker'

Faker::UniqueGenerator.clear # Reset Faker's unique generator

# Create roles
Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')

Rails.logger.debug { "Created roles: #{Role.pluck(:name)}" }

# Create users with roles and Faker
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

Rails.logger.debug { "Created admin user: #{admin.email}" }
Rails.logger.debug { "Created admin user: #{admin.password}" }

# Create teachers
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
  Rails.logger.debug { "Created teacher: #{teacher.email}" }
end

# Create curator (also a teacher)
curator = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  middle_name: Faker::Name.middle_name,
  phone_number: Faker::PhoneNumber.cell_phone,
  email: Faker::Internet.unique.email,
  password: 'password',
  password_confirmation: 'password',
  status: true,
  date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 45)
)
curator.add_role(:teacher)
Rails.logger.debug { "Created curator: #{curator.email}" }

# Create semesters
3.times do |i|
  semester = Semester.create!(
    name: "Semester #{i + 1}",
    start_date: Faker::Date.between(from: 2.years.ago, to: Time.zone.today),
    end_date: Faker::Date.between(from: Time.zone.today, to: 2.years.from_now)
  )
  Rails.logger.debug { "Created semester: #{semester.name}" }
end

# Create groups with curator
3.times do |i|
  group = Group.find_or_create_by(
    name: "Group #{i + 1}",
    curator_id: curator.id
  )
  Rails.logger.debug { "Created group: #{group.name}" }
end

# Create specializations with unique names
specialization_list = ['Computer Science', 'Engineering', 'Business', 'Arts', 'Humanities']
specialization_list.shuffle.each do |name|
  specialization = Specialization.find_or_create_by!(name: name)
  Rails.logger.debug { "Created specialization: #{specialization.name}" }
end

# Create students and record books
20.times do |_i|
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
  Rails.logger.debug { "Created student: #{student.email}" }

  rb = RecordBook.create!(
    user: student,
    specialization: Specialization.all.sample,
    group: Group.all.sample
  )
  Rails.logger.debug { "Created record book for student #{student.email}" }

  subjects_list = [
    'Mathematics', 'Physics', 'Chemistry', 'Biology', 'History', 'Geography',
    'Literature', 'Computer Science', 'Foreign Language', 'Art'
  ]
  subjects_list.each do |subject_name|
    subject = Subject.create!(
      name: subject_name,
      description: Faker::Lorem.paragraph,
      semester: Semester.all.sample
    )
    Rails.logger.debug { "Created subject: #{subject.name}" }

    SubjectsRecordBook.create!(record_book: rb, subject: subject)

    3.times do |_i|
      teacher = User.last
      attestation = IntermediateAttestation.create!(
        subject: subject,
        teacher: teacher,
        name: ['Midterm', 'Final Exam', 'Project Presentation', 'Quiz'].sample,
        date: Faker::Date.between(from: 3.months.ago, to: Time.zone.today),
        assessment_type: %w[Written Oral Practical].sample
      )
      Rails.logger.debug { "Created attestation: #{attestation.name} for subject #{attestation.subject.name}" }
    end

    subject = Subject.all.sample
    grade = Grade.create!(subject_id: subject.id, grade: rand(60..100), date: Time.zone.today)
    Rails.logger.debug { "Added grade #{grade.grade} for subject ID: #{subject.id}" }
  end
end
