RSpec.describe Grade do
  describe 'associations' do
    it { is_expected.to belong_to(:record_book) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:grade) }
  end

  describe 'creation' do
    let(:record_book) { create(:record_book, :with_associations) }

    it 'creates a grade with a record book' do
      grade = create(:grade, record_book: record_book)
      expect(grade).to be_valid
      expect(grade.record_book).to eq(record_book)
    end
  end
end
