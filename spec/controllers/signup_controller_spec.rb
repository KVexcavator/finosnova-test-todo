require 'rails_helper'

RSpec.describe SignupController, type: :controller do

  describe 'POST #create' do

    let(:user_params) { { email: 'test@email.com', password: 'password', password_confirmation: 'password' } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
    end

    it 'creates a new user' do
      expect do
        post :create, params: user_params
        expect(response).to change(User, :count).by(1)
      end
    end
    
  end
end
