require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should belong_to(:user).required }
  it { should belong_to(:specialization).required }
  it { should belong_to(:group).required }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:specialization) }
  it { should validate_presence_of(:group) }

  it "creates a student with valid attributes" do
    user = FactoryBot.create(:user)
    specialization = FactoryBot.create(:specialization)
    group = FactoryBot.create(:group)

    student = FactoryBot.build(:student, user: user, specialization: specialization, group: group)
    expect(student.save).to be_truthy
  end

  it "does not create a student without associated objects" do
    student = FactoryBot.build(:student, user: nil, specialization: nil, group: nil)
    expect(student.save).to be_falsey
    expect(student.errors.full_messages).to include(
      "User must exist",
      "Specialization must exist",
      "Group must exist",
      "User can't be blank",
      "Specialization can't be blank",
      "Group can't be blank"
    )
    end
end
