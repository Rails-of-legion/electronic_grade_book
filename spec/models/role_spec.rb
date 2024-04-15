require 'rails_helper'

RSpec.describe Role do
  it { is_expected.to have_and_belong_to_many(:users).join_table(:users_roles) }
  it { is_expected.to validate_inclusion_of(:resource_type).in_array(Rolify.resource_types).allow_nil }
  it { is_expected.to validate_presence_of(:name) }
end
