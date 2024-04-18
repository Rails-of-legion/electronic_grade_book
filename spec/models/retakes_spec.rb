require 'rails_helper'

RSpec.describe Retake do
  it { is_expected.to belong_to(:subject) }
  it { is_expected.to belong_to(:student) }
  it { is_expected.to belong_to(:grade) }

  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:student) }
  it { is_expected.to validate_presence_of(:grade) }
end
