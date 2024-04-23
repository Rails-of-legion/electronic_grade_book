class Attendance < ApplicationRecord
  validates :date, presence: true
  validates :attendance_status, presence: true

  belongs_to :subject
  belongs_to :record_book

  def self.ransackable_associations(_auth_object = nil)
    %w[record_book subject]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[attendance_status created_at date id id_value record_book_id subject_id updated_at]
  end
end
