require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(50) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { is_expected.to validate_presence_of(:date_of_birth) }
  it { is_expected.to allow_value('valid@email.com').for(:email) }
  it { is_expected.not_to allow_value('invalid_email').for(:email) }
  it { is_expected.to validate_confirmation_of(:password) }

  context 'when creating a user with a role' do
    it 'creates a user with the specified role' do
      user = create(:user, role_name: 'teacher')
      expect(user.roles.first.name).to eq('teacher')
    end

    it 'creates a student by default' do
      user = create(:user)
      expect(user.roles.first.name).to eq('student')
    end

    it 'returns users with the specified role' do
      teacher = create(:user, role_name: 'teacher')
      create(:user, role_name: 'student')
      expect(described_class.by_role('teacher')).to eq([teacher])
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:teachers_subjects).with_foreign_key(:teacher_id) }
    it { is_expected.to have_many(:subjects).through(:teachers_subjects) }
  end
end
