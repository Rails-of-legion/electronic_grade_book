class Group < ApplicationRecord
  belongs_to :curator, class_name: 'User', optional: true
  belongs_to :specialization
  has_many :record_books, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2 }

  def self.ransackable_associations(_auth_object = nil)
    %w[curator record_books]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at curator_id id id_value name updated_at]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at curator_id id id_value name specialization_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[curator record_books specialization]
  end
end
