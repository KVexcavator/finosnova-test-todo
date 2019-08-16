require 'rails_helper'

RSpec.describe SigninController, type: :controller do
  describe 'POST #create' do
    
    let(:user_params) { { email: 'rspec@mail.com', password: 'rspec333' } }
    # do it postman
    # it 'returns http success' do
    #   post :create, params: user_params
    #   expect(response).to be_successful
    #   expect(response_json.keys).to eq ['token']
    # end

    it 'returns unauthorized for invalid params' do
      post :create, params: { email: 'rspec@mail.com', password: 'incorrect' }
      expect(response).to have_http_status(401)
    end
  end
end
