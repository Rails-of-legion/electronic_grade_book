class TeachersSubject < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  belongs_to :subject
end
