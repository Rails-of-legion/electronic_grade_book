require 'rails_helper'

RSpec.describe Student, type: :model do
  # Ассоциации
  it { should belong_to(:user).required }
  it { should belong_to(:specialization).required }
  it { should belong_to(:group).required }

  # Тест наличия связанных объектов
  describe 'associations' do
    it 'is invalid without a user' do
      student = build(:student, user: nil)
      expect(student).to_not be_valid
      expect(student.errors[:user]).to include("must exist")
    end

    it 'is invalid without a specialization' do
      student = build(:student, specialization: nil)
      expect(student).to_not be_valid
      expect(student.errors[:specialization]).to include("must exist")
    end

    it 'is invalid without a group' do
      student = build(:student, group: nil)
      expect(student).to_not be_valid
      expect(student.errors[:group]).to include("must exist")
    end
  end
end
