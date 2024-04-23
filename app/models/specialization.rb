class Specialization < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :specialities_subjects, class_name: 'SpecialitiesSubject', dependent: :destroy
  has_many :subjects, through: :specialities_subjects

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.ransackable_associations(_auth_object = nil)
    ['students']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name updated_at]
  end
end
