class Student < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :specialization, required: true
  belongs_to :group, required: true
end
