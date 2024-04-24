class AttendancesRecordBook < ApplicationRecord
    belongs_to :attendance
    belongs_to :record_book
end