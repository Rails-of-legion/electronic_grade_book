class Student < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :specialization, optional: false
  belongs_to :group, optional: false
  has_one :record_book, dependent: :destroy
  has_many :retakes, dependent: :destroy
end
