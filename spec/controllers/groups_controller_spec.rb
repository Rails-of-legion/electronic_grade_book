require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:group) { create(:group) }
  let(:specialization) { create(:specialization) }
  let(:subject) { create(:subject) }
  let(:record_book) { create(:record_book, group: group) }
  let(:params) { { group_id: group.id, month: 8, subject_id: subject.id } }

  describe 'GET #index' do
    it 'assigns @groups and renders the index template' do
      get :index
      expect(assigns(:groups)).to include(group)
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'responds to JSON format' do
      request.headers['Accept'] = 'application/json'
      get :index
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'GET #show' do
    it 'assigns @group and @subjects and renders the show template' do
      get :show, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
      expect(assigns(:subjects)).to eq(group.specialization.subjects)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'responds to JSON format' do
      request.headers['Accept'] = 'application/json'
      get :show, params: { id: group.id }
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'GET #form_teacher' do
    it 'assigns @record_books and renders the form_teacher partial' do
      get :form_teacher, params: params
      expect(assigns(:record_books)).to include(record_book)
      expect(response).to be_successful
      expect(response).to render_template(partial: '_form_teacher')
    end

    it 'responds to JS format' do
      request.headers['Accept'] = 'application/javascript'
      get :form_teacher, params: params
      expect(response.content_type).to eq('application/javascript; charset=utf-8')
    end
  end

  describe 'GET #new' do
    it 'assigns a new Group to @group and renders the new template' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns @group and renders the edit template' do
      get :edit, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Group and redirects to the group' do
        expect {
          post :create, params: { group: attributes_for(:group) }
        }.to change(Group, :count).by(1)
        expect(response).to redirect_to(Group.last)
        expect(flash[:notice]).to eq(I18n.t('questions.group_create_notice'))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Group and re-renders the new template' do
        post :create, params: { group: attributes_for(:group, name: nil) }
        expect(Group.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the group and redirects to the group' do
        patch :update, params: { id: group.id, group: { name: 'New Name' } }
        group.reload
        expect(group.name).to eq('New Name')
        expect(response).to redirect_to(group)
        expect(flash[:notice]).to eq(I18n.t('questions.group_update_notice'))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the group and re-renders the edit template' do
        patch :update, params: { id: group.id, group: { name: nil } }
        expect(group.reload.name).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the group and redirects to the groups index' do
      group
      expect {
        delete :destroy, params: { id: group.id }
      }.to change(Group, :count).by(-1)
      expect(response).to redirect_to(groups_url)
      expect(flash[:notice]).to eq(I18n.t('questions.group_destroy_notice'))
    end
  end

  describe 'GET #by_specialization' do
    it 'responds with JSON containing groups by specialization' do
      get :by_specialization, params: { id: specialization.id }
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to include(group.to_json)
    end
  end
end
