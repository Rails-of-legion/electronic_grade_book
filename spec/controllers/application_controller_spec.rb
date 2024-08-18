require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller(ApplicationController) do
    before_action :authenticate_admin_user!, only: [:index]
    
    def index
      render plain: "Home"
    end

    def show
      render plain: default_title
    end
  end


  describe "#after_sign_in_path_for" do
    let(:user) { create(:user) }

    context "when the user is an admin" do
      before { allow(user).to receive(:admin?).and_return(true) }

      it "redirects to user path" do
        expect(controller.after_sign_in_path_for(user)).to eq(user_path(user))
      end
    end

    context "when the user is a teacher" do
      before { allow(user).to receive(:teacher?).and_return(true) }

      it "redirects to user path" do
        expect(controller.after_sign_in_path_for(user)).to eq(user_path(user))
      end
    end

    context "when the user is a student" do
      before { allow(user).to receive(:student?).and_return(true) }

      it "redirects to user path" do
        expect(controller.after_sign_in_path_for(user)).to eq(user_path(user))
      end
    end
  end


  describe "#switch_locale" do
    let(:action) { Proc.new { get :index } }

    context "when locale is available" do
      it "switches to the requested locale" do
        allow(controller).to receive(:params).and_return({ locale: 'ru' })
        expect(I18n).to receive(:with_locale).with('ru')
        controller.send(:switch_locale, &action)
      end
    end

    context "when locale is not available" do
      it "uses the default locale" do
        allow(controller).to receive(:params).and_return({ locale: 'xx' })
        expect(I18n).to receive(:with_locale).with(I18n.default_locale)
        controller.send(:switch_locale, &action)
      end
    end
  end

  describe "#access_denied" do
    let(:exception) { CanCan::AccessDenied.new("Not authorized!") }

    it "redirects to the root path with an alert" do
      # Ensure request/response are properly initialized
      expect(controller).to receive(:redirect_to).with(root_path, alert: "Not authorized!")
      controller.send(:access_denied, exception)
    end
  end
end
