# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Role.create(name: 'admin')
Role.create(name: 'teacher')
Role.create(name: 'student')

admin = User.create(name: 'admin', email: 'admin@localhost', password: 'admin', status: true, date_of_birth: Date.new(2000, 1, 1))
admin.add_role(:admin)

teacher = User.create(name: 'teacher', email: 'teacher@localhost', password: 'teacher', status: true, date_of_birth: Date.new(2000, 1, 1))
teacher.add_role(:teacher)

student = User.create(name: 'student', email: 'student@localhost', password: 'student', status: true, date_of_birth: Date.new(2000, 1, 1))
student.add_role(:student)