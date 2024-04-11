class Subject < ApplicationRecord

  validates :name, presence: true, length: { minimum: 3 }

  validates :description, presence: true

  validates :semester_id, presence: true

  validates :assessment_type, presence: true

end
