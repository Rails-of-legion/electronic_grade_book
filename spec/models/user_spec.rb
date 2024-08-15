require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without a first name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "is not valid with a too short first name" do
      user.first_name = "Jo"
      expect(user).to_not be_valid
    end

    it "is not valid phone nuber" do
      user.phone_number = "+376297642917"
      expect(user).to_not be_valid
    end

    it "is not valid date of birth" do
      user.date_of_birth = nil
      expect(user).to_not be_valid
    end
  end

  describe "associations" do
    it { should have_many(:curated_groups).class_name('Group').with_foreign_key('curator_id').dependent(:destroy) }
    it { should have_many(:notifications_users).dependent(:destroy) }
    it { should have_many(:notifications).through(:notifications_users) }
    it { should have_many(:teachers_subjects).with_foreign_key('teacher_id').dependent(:nullify) }
    it { should have_many(:subjects).through(:teachers_subjects) }
    it { should have_one(:record_book).dependent(:destroy) }
    it { should have_many(:intermediate_attestation).with_foreign_key('teacher_id').dependent(:destroy) }
  end

  describe "methods" do
    it "ransackables associations includes record_book and_roles" do
      expect(User.ransackable_associations).to include("record_book", "roles")
    end

    it 'includes default associations from super' do
      default_associations = User.reflect_on_all_associations.map(&:name).map(&:to_s)
      associations = User.ransackable_associations

      expect(associations).to include(*default_associations)
    end

    it 'returns attributes that exist as columns or associations in the User model' do
      ransackable_attributes = User.ransackable_attributes

      ransackable_attributes.each do |attribute|
        is_column = User.column_names.include?(attribute)
        is_association = User.reflect_on_all_associations.map(&:name).map(&:to_s).include?(attribute)

        expect(is_column || is_association).to be(true), "Expected #{attribute} to be a column or association"
      end
    end

    it "returns valid full name" do
      user.first_name = "John"
      user.last_name = "Doe"
      user.middle_name = "Middle"

      expect(user.name).to eq("Doe John Middle")
    end

    it "returns valid short name" do
      user.first_name = "John"
      user.last_name = "Doe"
      user.middle_name = "Middle"

      expect(user.format_full_name).to eq("Doe J.M.")
    end

    it
  end
end
