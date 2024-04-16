#require 'rails_helper'
#
#RSpec.describe StudentsController, type: :controller do
#  describe "POST #create" do
#    context "с валидными параметрами" do
#      let(:valid_attributes) { { user_id: 1, specialization_id: 1, group_id: 1 } }
#
#      it "создает нового студента" do
#        expect {
#          post :create, params: { student: valid_attributes }
#        }.to change(Student, :count).by(1)
#      end
#
#      it "перенаправляет на страницу нового студента" do
#        post :create, params: { student: valid_attributes }
#        expect(response).to redirect_to(student_path(Student.last))
#      end
#    end
#
#    context "с невалидными параметрами" do
#      let(:invalid_attributes) { { user_id: nil, specialization_id: nil, group_id: nil } }
#
#      it "не создает нового студента" do
#        expect {
#          post :create, params: { student: invalid_attributes }
#        }.to_not change(Student, :count)
#      end
#
#      it "остается на странице создания и отображает ошибки" do
#        post :create, params: { student: invalid_attributes }
#        expect(response).to have_http_status(:unprocessable_entity)
#        expect(response).to render_template(:new)
#      end
#    end
#  end
#end
#
#describe "DELETE #destroy" do
#  let!(:student) { create(:student) }
#
#  it "удаляет студента" do
#    expect {
#      delete :destroy, params: { id: student.id }
#    }.to change(Student, :count).by(-1)
#  end
#
#  it "перенаправляет на список студентов" do
#    delete :destroy, params: { id: student.id }
#    expect(response).to redirect_to(students_path)
#  end
#end