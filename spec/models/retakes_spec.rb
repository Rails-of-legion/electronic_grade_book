require 'rails_helper'

RSpec.describe Retake do
  it { is_expected.to belong_to(:subject) }
  it { is_expected.to belong_to(:student) }
  it { is_expected.to belong_to(:grade) }
end
