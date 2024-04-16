class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :middle_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :phone_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates_associated :groups
  validates_associated :notifications

  scope :by_role, ->(role_name) { joins(:roles).where(roles: { name: role_name }) }
  has_many :curated_groups, class_name: 'Group', foreign_key: 'curator_id', dependent: :destroy
  has_many :notifications
  has_many :groups
  has_many :teachers_subjects, foreign_key: :teacher_id
  has_many :subjects, through: :teachers_subjects
  has_many :record_books, foreign_key: :teacher_id, dependent: :destroy

  # def name
  #  "#{first_name} #{last_name} #{middle_name}"
  # end
end
