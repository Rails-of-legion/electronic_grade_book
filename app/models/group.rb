class Group < ApplicationRecord
  belongs_to :curator, class_name: 'User', optional: true
  has_many :record_books, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2 }

  def self.ransackable_associations(_auth_object = nil)
    ['curator']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at curator_id id id_value name updated_at]
  end
end
