require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /login" do
    let!(:user) { User.create(username: 'admin', password: 'admin') }

    scenario 'valid user attributes' do
      post '/login', params: {
        username: 'admin',
        password: 'admin'
      }
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:user]).to be_present
      expect(json[:token]).to be_present
    end

    scenario 'invalid user attributes' do
      post '/login', params: {
        username: '',
        password: ''
      }
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:error]).to eq('Invalid username or password')
    end
  end
end