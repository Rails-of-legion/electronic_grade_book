class Specialization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates_format_of :name, with: /\A[a-zA-Zа-яА-Я\s]+\z/, message: 'only allows letters and spaces'

    has_many :students, dependent: :destroy
end
