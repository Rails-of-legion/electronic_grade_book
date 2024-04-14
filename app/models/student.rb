class Student < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :specialization, optional: false
  belongs_to :group, optional: false
end
