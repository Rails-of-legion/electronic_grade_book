require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should belong_to(:curator).class_name('User').optional }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }
end

