require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:admin) { create(:user, :as_admin) }
  let(:teacher) { create(:user, :as_teacher) }
  let(:student) { create(:user, :as_student) }
  let!(:subjects) { create_list(:subject, 5) }
  let!(:subject) { create(:subject) }

  describe 'GET #index' do
    context 'when user is an admin' do
      let(:user) { admin }

      before do
        sign_in user
        get :index
      end

      it 'assigns all subjects to @subjects' do
        expect(assigns(:subjects)).to match_array(Subject.all)
      end
    end
    context 'when user is a teacher' do
      let(:user) { teacher }

      before do
        sign_in user
        get :index
      end

      it 'assigns all subjects to @subjects' do
        expect(assigns(:subjects)).to match_array(Subject.all)
      end
    end

    context 'when user is a student' do
      let(:user) { student }
      let(:student_subjects) { create_list(:subject, 3) }
      let(:student_subject_ids) { student_subjects.map(&:id) }

      before do
        sign_in user
        allow_any_instance_of(SubjectsController).to receive(:student_subjects).and_return(Subject.where(id: student_subject_ids))
        get :index
      end

      it 'assigns only student subjects to @subjects' do
        expect(assigns(:subjects)).to match_array(student_subjects)
      end
    end
  end
  describe 'GET #edit' do
    context 'when user is an admin' do
      before do
        sign_in admin
        get :edit, params: { id: subject.id }
      end

      it 'allows access to the edit page' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is a teacher' do
      before do
        sign_in teacher
      end

      it 'denies access' do
        expect {
          get :edit, params: { id: subject.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when user is a student' do
      before do
        sign_in student
      end

      it 'denies access' do
        expect {
          get :edit, params: { id: subject.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
  describe 'PATCH #update' do
    let(:valid_attributes) { { name: 'Updated Subject Name' } }

    context 'when user is an admin' do
      before do
        sign_in admin
        patch :update, params: { id: subject.id, subject: valid_attributes }
      end

      it 'updates the subject' do
        expect(subject.reload.name).to eq('Updated Subject Name')
      end

      it 'redirect to the subject page' do
        expect(response).to redirect_to(subject_path(subject))
      end
    end

    context 'when user is a teacher' do
      before do
        sign_in teacher
      end

      it 'denies access' do
        expect {
          patch :update, params: { id: subject.id, subject: valid_attributes }
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when user is a student' do
      before do
        sign_in student
      end

      it 'denies access' do
        expect {
          patch :update, params: { id: subject.id, subject: valid_attributes }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'when user is an admin' do
      before do
        sign_in admin
      end

      it 'deletes the subject' do
        expect {
          delete :destroy, params: { id: subject.id }
        }.to change(Subject, :count).by(-1)
      end

      it 'redirects to subjects index' do
        delete :destroy, params: { id: subject.id }
        expect(response).to redirect_to(subjects_path)
      end
    end

    context 'when user is a teacher' do
      before do
        sign_in teacher
      end

      it 'denies access' do
        expect {
          delete :destroy, params: { id: subject.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when user is a student' do
      before do
        sign_in student
      end

      it 'denies access' do
        expect {
          delete :destroy, params: { id: subject.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
  describe 'GET #show' do
    context 'when user is a admin' do
      let(:user) { admin }
      before do
        sign_in admin
      end

      it 'assigns the requested subject to @subject' do
        get :show, params: { id: subject.id }
        expect(assigns(:subject)).to eq(subject)
      end
    end
    context 'when user is a teacher' do
      let(:user) { teacher }
      before do
        sign_in teacher
      end

      it 'assigns the requested subject to @subject' do
        get :show, params: { id: subject.id }
        expect(assigns(:subject)).to eq(subject)
      end
    end

    context 'when user is a student' do
      let(:user) { student }
      before do
        sign_in student
      end

      it 'assigns the requested subject to @subject' do
        get :show, params: { id: subject.id }
        expect(assigns(:subject)).to eq(subject)
      end
    end
  end
end
