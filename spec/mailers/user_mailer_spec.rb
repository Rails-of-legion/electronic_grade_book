require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#registration_confirmation' do
    let(:user) { create(:user, email: 'test@example.com') } # Используем FactoryBot для создания пользователя
    let(:mail) { UserMailer.registration_confirmation(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Welcome to our app!')
    end

    it 'sends to the correct email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['from@example.com']) # Убедитесь, что этот адрес совпадает с тем, что установлен в вашем приложении
    end

    it 'assigns @user in text part' do
      expect(mail.text_part.body.encoded).to match(user.email)
    end
    
    it 'assigns @user in html part' do
      expect(mail.html_part.body.encoded).to match(user.email)
    end

    it 'sends the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
