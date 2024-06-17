class Specialization < ApplicationRecord
  has_many :specialities_subjects, class_name: 'SpecialitiesSubject', dependent: :destroy
  has_many :subjects, through: :specialities_subjects
  has_many :record_books, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }


  def self.ransackable_associations(auth_object = nil)
    [:subjects, :groups, :record_books] 
  end
  

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name updated_at]
  end
end
