require 'faker'

Faker::UniqueGenerator.clear  # Reset Faker's unique generator

# Create roles
Role.create(name: "admin")
Role.create(name: "teacher")
Role.create(name: "student")

puts "Created roles: #{Role.pluck(:name)}"

# Create users with roles and Faker
admin = User.create!(
  login: "admin",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  middle_name: Faker::Name.middle_name,
  phone_number: Faker::PhoneNumber.cell_phone,
  email: Faker::Internet.unique.email,
  password: "password",
  password_confirmation: "password",
  status: true,
  date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 50)
)
admin.add_role(:admin)

puts "Created admin user: #{admin.login}"

# Create teachers
2.times do |i|
  teacher = User.create!(
    login: "teacher#{i+1}",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.middle_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    status: true,
    date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 40)
  )
  teacher.add_role(:teacher)
  puts "Created teacher: #{teacher.login}"
end

# Create curator (also a teacher)
curator = User.create!(
  login: "curator",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  middle_name: Faker::Name.middle_name,
  phone_number: Faker::PhoneNumber.cell_phone,
  email: Faker::Internet.unique.email,
  password: "password",
  password_confirmation: "password",
  status: true,
  date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 45)
)
curator.add_role(:teacher)
puts "Created curator: #{curator.login}"

# Create semesters
3.times do |i|
  semester = Semester.create!(
    name: "Semester #{i + 1}",
    start_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    end_date: Faker::Date.between(from: Date.today, to: 2.years.from_now)
  )
  puts "Created semester: #{semester.name}"
end

# Create subjects
subjects_list = [
  "Mathematics", "Physics", "Chemistry", "Biology", "History", "Geography",
  "Literature", "Computer Science", "Foreign Language", "Art"
]
subjects_list.each do |subject_name|
  subject = Subject.create!(
    name: subject_name,
    description: Faker::Lorem.paragraph,
    assessment_type: ["Exam", "Project", "Essay"].sample,
    semester: Semester.all.sample
  )
  puts "Created subject: #{subject.name}"
end

# Assign teachers to subjects (ensure each subject has at least one teacher)
Subject.all.each do |subject|
  teacher = User.with_role(:teacher).sample
  TeachersSubject.create!(teacher: teacher, subject: subject)
  puts "Assigned teacher #{teacher.login} to subject #{subject.name}"
end

# Create intermediate attestations 
3.times do |i|
  attestation = IntermediateAttestation.create!(
    subject: Subject.all.sample,
    name: ["Midterm", "Final Exam", "Project Presentation", "Quiz"].sample,
    date: Faker::Date.between(from: 3.months.ago, to: Date.today),
    max_grade: rand(1..10),
    assessment_type: ["Written", "Oral", "Practical"].sample
  )
  puts "Created attestation: #{attestation.name} for subject #{attestation.subject.name}"
end

# Create groups with curator 
3.times do |i|
  group = Group.find_or_create_by(
    name: "Group #{i+1}",
    curator_id: curator.id
  )
  puts "Created group: #{group.name}" 
end 
 
# Create specializations with unique names 
specialization_list = ["Computer Science", "Engineering", "Business", "Arts", "Humanities"] 
specialization_list.shuffle.each do |name|   
  specialization = Specialization.find_or_create_by!(name: name)
  puts "Created specialization: #{specialization.name}" 
end 

# Create students and record books 
20.times do |i|
  student = User.create!(
    login: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.middle_name,
    phone_number: Faker::PhoneNumber.cell_phone, 
    email: Faker::Internet.unique.email, 
    password: "password",
    password_confirmation: "password",
    status: [true, false].sample,
    date_of_birth: Faker::Date.birthday(min_age: 17, max_age: 23)
  )
  student.add_role(:student)
  puts "Created student: #{student.login}"

  # Find a valid teacher for the subject
  subject = Subject.all.sample
  teacher = subject.teachers.sample

  record_book = RecordBook.create!( 
    user: student, 
    specialization: Specialization.all.sample, 
    group: Group.all.sample, 
    subject: subject, 
    intermediate_attestation: IntermediateAttestation.all.sample 
  ) 
  puts "Created record book for student #{student.login} in subject #{subject.name}" 
end 
 
# Create grades 
RecordBook.all.each do |record_book| 
  grade = Grade.create!(record_book: record_book, grade: rand(60..100))
  puts "Added grade #{grade.grade} to record book ID: #{record_book.id}"
end 
 
# Create retakes and associate with record books (example for one retake) 
retake = Retake.create!(subject: Subject.first, date: Date.today + 1.week, grade: Grade.first) 
RetakesRecordBook.create!(retake: retake, record_book: RecordBook.first) 
puts "Created retake for subject #{retake.subject.name} and associated with record book ID: #{RecordBook.first.id}"