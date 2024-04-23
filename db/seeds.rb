Role.create(name: "admin")
Role.create(name: "teacher")
Role.create(name: "guest")

admin = User.create(login: "admin", first_name: "admin", last_name: "admin", middle_name: "admin", phone_number: "12345678",  email: "admin@localhost", password: "12345678", password_confirmation: "12345678", status: true, date_of_birth: "2020-04-10") if Rails.env.development?
admin.add_role(:admin)
teacher = User.create(login: "teach", first_name: "teacher", last_name: "teacher", middle_name: "teacher", phone_number: "12345678", email: "teacher@localhost", password: "12345678", password_confirmation: "12345678", status: false, date_of_birth: "2020-04-10")
teacher.add_role(:teacher)

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

record_book = RecordBook.create(user_id: 3, specialization_id: rand(1..3), group_id: rand(1..3), subject_id: 1, teacher_id: 2, intermediate_attestation_id: 1)

Grade.create(record_book_id: record_book.id, grade: rand(1..10))

Retake.create(subject_id: 1, student_id: record_book.id, date: "2020-04-10", grade_id: 1)
