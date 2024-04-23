class SpecialitiesSubject < ApplicationRecord
  belongs_to :specialization
  belongs_to :subject
end
