require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /login" do
    scenario 'valid user attributes' do
      build(:user)

      post '/login', params: {
        username: 'example',
        password: 'example'
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