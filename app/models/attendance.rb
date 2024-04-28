class Attendance < ApplicationRecord
  validates :date, presence: true
  validates :attendance_status, presence: true

  belongs_to :subject
  has_many :attendances_record_books, dependent: :destroy
  has_many :record_books, through: :attendances_record_books

  def self.ransackable_attributes(_auth_object = nil)
    %w[attendance_status created_at date id id_value subject_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[attendances_record_books record_books subject]
  end
end
