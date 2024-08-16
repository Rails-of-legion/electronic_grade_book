# spec/helpers/home_helper_spec.rb

require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#name' do
    let(:user) { double('User', last_name: 'Иванов', first_name: 'Иван', middle_name: 'Иванович') }

    it 'returns the full name of the user' do
      expect(helper.name(user)).to eq('Иванов Иван Иванович ')
    end

    it 'returns an empty string when user attributes are blank' do
      user = double('User', last_name: '', first_name: '', middle_name: '')
      expect(helper.name(user)).to eq(' ')
    end

    it 'handles nil attributes gracefully' do
      user = double('User', last_name: nil, first_name: nil, middle_name: nil)
      expect(helper.name(user)).to eq(' ')
    end
  end
end
