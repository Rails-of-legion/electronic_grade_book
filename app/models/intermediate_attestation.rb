class IntermediateAttestation < ApplicationRecord
  belongs_to :subject, optional: false
  belongs_to :teacher, class_name: 'User'
  belongs_to :group
  has_many :record_books_intermediate_attestations, dependent: :destroy
  has_many :record_books, through: :record_books_intermediate_attestations

  validates :name, :date, :assessment_type, presence: true

  after_create :associate_students_to_attestation

  def self.ransackable_attributes(_auth_object = nil)
    %w[assessment_type created_at date id id_value name subject_id teacher_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[record_books record_books_intermediate_attestations subject teacher]
  end

  def associate_students_to_attestation
    record_books.each do |record_book|
      record_book.intermediate_attestations << self
    end
  end

end
