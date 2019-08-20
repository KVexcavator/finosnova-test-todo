require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:user) { create(:user) }

  let(:attributes) {{ 
    title: 'My title',
    body: '0. Развернуть Restfull API приложение. Database Postgres.
    1. Сделать Регистрацию для Restfull API приложения, с использованием jwt. Приложение должно
    выдавать токен на 24 часа. По истечению срока действия токена, пользователь выходит из системы.
    * 1.0. Добавить возможность обновления токена, то есть для поддержании статуса авторизации.',
    finished: true,
    # user_id:  
  }}

  describe 'GET #index' do
    let!(:todo) { create(:todo, user: user) }
    context 'list all todos' do
      it 'returns a success response' do
        get :index
        expect(response_json.keys).to eq ["sos"]
      end
    end

    context 'list finished todos' do
      let!(:todo) { create(:todo, user: user) }
      it 'returns a success response' do
        get :index
        @switch = 1
        expect(response_json.keys).to eq ["sos"]
      end
    end

  end

  describe 'GET #show' do
    let!(:todo) { create(:todo, user: user) }

    it 'returns a json woth date' do
      get :show, params: { id: todo.id }
      expect(response_json.keys).to eq ["sos"]
    end
  end

  describe 'POST #create' do
    it 'creates a new Todo' do
      expect {
        post :create, params: { todo: attributes }
      }.to change(Todo, :count).by(1)
    end

    it 'renders a JSON response with the new todo' do
      post :create, params: { todo: attributes }
      expect(response.content_type).to eq('application/json')
    end

  end

  describe 'PUT #update' do
    let!(:todo) { create(:todo, user: user) }   
    let(:new_attributes) {{ title: 'My NoFactory title' }}

    it 'updates the requested todo' do
      put :update, params: { id: todo.id, todo: new_attributes }
      todo.reload
      expect(todo.title).to eq new_attributes[:title]
    end

    it 'renders a JSON response with the todo' do        
      put :update, params: { id: todo.to_param, todo: attributes }
      expect(response.content_type).to eq('application/json')
    end
   
  end

  describe 'DELETE #destroy' do
    let!(:todo) { create(:todo, user: user) }

    it 'destroys the requested todo' do
      expect {
        delete :destroy, params: { id: todo.id }
      }.to change(Todo, :count).by(-1)
    end
  end
end
