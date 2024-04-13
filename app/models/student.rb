class Student < ApplicationRecord
  belongs_to :user
  belongs_to :speciality
  belongs_to :group
end
