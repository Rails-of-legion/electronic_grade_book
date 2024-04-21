# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Role.create(name: "admin")
Role.create(name: "teacher")
Role.create(name: "student")
Role.create(name: "guest")

admin = User.create(login: "admin", first_name: "admin", last_name: "admin", middle_name: "admin", phone_number: "12345678",  email: "admin@localhost", password: "12345678", password_confirmation: "12345678", status: true, date_of_birth: "2020-04-10") if Rails.env.development?
admin.add_role(:admin)
teacher = User.create(login: "teach", first_name: "teacher", last_name: "teacher", middle_name: "teacher", phone_number: "12345678", email: "teacher@localhost", password: "12345678", password_confirmation: "12345678", status: false, date_of_birth: "2020-04-10")
teacher.add_role(:teacher)
student = User.create(login: "stud", first_name: "student", last_name: "student", middle_name: "student", phone_number: "12345678", email: "student@localhost", password: "12345678", password_confirmation: "12345678", status: true, date_of_birth: "2020-04-10")
student.add_role(:student)

3.times do
    Semester.create(name: "Semester #{rand(1..10)}", start_date: "2020-04-10", end_date: "2020-04-10")
end

3.times do
    Subject.create(name: "Subject #{rand(1..10)}", description: "Description #{rand(1..10)}", assessment_type: "assessment_type #{rand(1..10)}", semester_id: rand(1..3))
end

3.times do
    TeachersSubject.create(teacher_id: rand(1..3), subject_id: rand(1..3))
end

3.times do
  IntermediateAttestation.create(subject_id: rand(1..3), name: "Name #{rand(1..10)}", date: "2020-04-10", max_grade: rand(1..10), assessment_type: "assessment_type #{rand(1..10)}")
end

3.times do
  Group.create(name: "Group #{rand(1..10)}", curator_id: 3)
end

3.times do
  Specialization.create(name: "Specialization #{rand(1..10)}")
end

Student.create(user_id: 3, specialization_id: rand(1..3), group_id: rand(1..3))

RecordBook.create(subject_id: 1, student_id: 1, teacher_id: 2, intermediate_attestation_id: 1)

Grade.create(record_book_id: 1, grade: rand(1..10))
