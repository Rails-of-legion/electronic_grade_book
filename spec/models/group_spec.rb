require 'rails_helper'

RSpec.describe Group do
  it { is_expected.to belong_to(:curator).class_name('User').optional }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2) }
end
