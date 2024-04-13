class Specialization < ApplicationRecord
  has_many :students, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
