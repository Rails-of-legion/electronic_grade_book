class Specialization < ApplicationRecord
  has_many :students, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.ransackable_associations(auth_object = nil)
    ["students"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
