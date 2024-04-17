class Retake < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :grade
end
