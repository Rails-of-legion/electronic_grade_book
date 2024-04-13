class Group < ApplicationRecord
  belongs_to :curator, class_name: 'User', optional: true

  validates :name, presence: true, length: { minimum: 2 }
end


