require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    scenario 'valid user attributes' do
      post '/users', params: {
        username: 'example2',
        password: 'example2'
      }
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:user]).to be_present
      expect(json[:token]).to be_present
    end

    scenario 'invalid user attributes' do
      post '/users', params: {
        username: '',
        password: ''
      }
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:error]).to eq('Invalid username or password')
    end
  end
end