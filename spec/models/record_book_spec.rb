require 'rails_helper'

RSpec.describe RecordBook do
  describe 'associations' do
    it { is_expected.to belong_to(:subject) }
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:teacher).class_name('User') }
    it { is_expected.to belong_to(:intermediate_attestation) }
  end

  it 'creates a record book with associations' do
    record_book = create(:record_book, :with_associations)
    expect(record_book).to be_valid
    expect(record_book.subject).to be_a(Subject)
    expect(record_book.student).to be_a(Student)
    expect(record_book.teacher).to be_a(User)
    expect(record_book.teacher.roles.first.name).to eq('teacher')
    expect(record_book.intermediate_attestation).to be_a(IntermediateAttestation)
  end
end
