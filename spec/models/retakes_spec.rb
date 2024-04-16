require 'rails_helper'

RSpec.describe Retake, type: :model do
  it { should belong_to(:subject) }
  it { should belong_to(:student) }
  it { should belong_to(:grade) }

  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:student) }
  it { should validate_presence_of(:grade) }
end