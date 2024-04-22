class SubjectRecordBook < ApplicationRecord
    belongs_to :subject
    belongs_to :record_book
  end