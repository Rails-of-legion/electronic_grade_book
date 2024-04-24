class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :middle_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :phone_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  validates :status, inclusion: { in: [true, false] }

  has_many :curated_groups, class_name: 'Group', foreign_key: 'curator_id', dependent: :destroy
  has_many :notifications_users
  has_many :notifications, through: :notifications_users
  has_many :groups
  has_many :teachers_subjects, foreign_key: :teacher_id
  has_many :subjects, through: :teachers_subjects
  has_one :record_books, dependent: :destroy

  scope :by_role, ->(role_name) { joins(:roles).where(roles: { name: role_name }) }

  def self.ransackable_associations(auth_object = nil)
    super & ['record_books']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      created_at
      date_of_birth
      email
      first_name
      last_name
      middle_name
      status
    ]
  end

  def has_no_roles?
    roles.empty?
  end

  def admin?
    has_role?(:admin)
  end

  def teacher?
    has_role?(:teacher)
  end

  def student?
    has_role?(:student)
  end

  def name
    "#{first_name} #{middle_name} #{last_name}".strip.presence || login
  end
end
