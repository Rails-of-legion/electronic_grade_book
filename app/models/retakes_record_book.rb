class RetakesRecordBook < ApplicationRecord
  belongs_to :retake
  belongs_to :record_book
end
