# spec/helpers/application_helper_spec.rb
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#user_role_translation' do
    let(:admin_role) { double(name: 'admin') }
    let(:teacher_role) { double(name: 'teacher') }
    let(:student_role) { double(name: 'student') }
    let(:other_role) { double(name: 'guest') }

    let(:admin_user) { double(roles: [admin_role]) }
    let(:teacher_user) { double(roles: [teacher_role]) }
    let(:student_user) { double(roles: [student_role]) }
    let(:other_user) { double(roles: [other_role]) }

    it 'translates admin role' do
      expect(helper.user_role_translation(admin_user)).to eq(I18n.t('home.admin'))
    end

    it 'translates teacher role' do
      expect(helper.user_role_translation(teacher_user)).to eq(I18n.t('home.teacher'))
    end

    it 'translates student role' do
      expect(helper.user_role_translation(student_user)).to eq(I18n.t('home.student'))
    end

    it 'returns the role name if translation is not found' do
      expect(helper.user_role_translation(other_user)).to eq('guest')
    end
  end
end
