class Student < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :specialization, optional: false
  belongs_to :group, optional: false
  has_one :record_book, dependent: :destroy
  has_many :retakes, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at group_id id id_value specialization_id updated_at user_id]
  end
  def self.ransackable_associations(auth_object = nil)
    ["group", "record_book", "retakes", "specialization", "user"]
  end

  def name
    user.name
  end  
end
