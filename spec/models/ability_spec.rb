# spec/models/ability_spec.rb
require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:admin) { create(:user, :as_admin) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:student) { create(:user, :as_student) }
  let(:guest) { nil } # Guest user is represented by nil

  context 'when user is an admin' do
    subject(:ability) { Ability.new(admin) }

    it { is_expected.to be_able_to(:manage, :all) }
  end

  context 'when user is a teacher' do
    subject(:ability) { Ability.new(teacher) }

    it { is_expected.to be_able_to(:read, Group) }
    it { is_expected.to be_able_to(:read, Specialization) }
    it { is_expected.not_to be_able_to(:read, User.new(id: 1)) }
    it { is_expected.to be_able_to(:read, User, id: teacher.id) }
    it { is_expected.to be_able_to(:read, IntermediateAttestation) }
    it { is_expected.to be_able_to(:read, RecordBook) }
    it { is_expected.to be_able_to(:manage, Grade) }
    it { is_expected.to be_able_to(:read, Semester) }
    it { is_expected.to be_able_to(:read, Subject) }
    it { is_expected.to be_able_to(:group_subjects, Subject) }
    it { is_expected.to be_able_to(:form_teacher, Group) }
  end

  context 'when user is a student' do
    subject(:ability) { Ability.new(student) }

    it { is_expected.not_to be_able_to(:read, User.new(id: 1)) }
    it { is_expected.to be_able_to(:read, User, id: student.id) }
    it { is_expected.to be_able_to(:read, Semester) }
    it { is_expected.to be_able_to(:read, RecordBook) }
    it { is_expected.to be_able_to(:read, Subject) }
  end

  context 'when user is a guest' do
    subject(:ability) { Ability.new(guest) }

    it { is_expected.to be_able_to(:read, :all) }
  end
end
