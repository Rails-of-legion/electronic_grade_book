class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :middle_name, presence: true, length: { minimum: 3, maximum: 50 }
  #validates :phone_number, presence: true
  #validates :phone_number, format: { with: /\A(\+375|80)(29|44|25|33)\d{7}\z/,
   #                                  message: 'неверный формат номера телефона' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  #validates :date_of_birth, presence: true
  validates :status, inclusion: { in: [true, false] }

  has_many :curated_groups, class_name: 'Group', foreign_key: 'curator_id', dependent: :destroy
  has_many :notifications_users, dependent: :destroy
  has_many :notifications, through: :notifications_users
  has_many :teachers_subjects, foreign_key: :teacher_id, dependent: :nullify
  has_many :subjects, through: :teachers_subjects
  has_one :record_book, dependent: :destroy
  has_many :intermediate_attestation, foreign_key: :teacher_id, dependent: :destroy

  before_save :set_expelled_at
  after_update :schedule_deletion_if_expelled
  def self.ransackable_associations(auth_object = nil)
    super + %w[record_book roles]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      created_at
      date_of_birth
      email
      first_name
      middle_name
      last_name
      status
      phone_number
      record_book
      roles
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
    "#{last_name} #{first_name} #{middle_name}".strip.presence || login
  end

  def format_full_name
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
  end

  private

  def set_expelled_at
    if expelled
      self.expelled_at = Time.zone.now
    else
      self.expelled_at = nil
    end
  end

  def schedule_deletion_if_expelled
    if expelled_changed? && expelled
      DeleteUserJob.set(wait: 1.minute).perform_later(self.id)
    end
  end
end


