require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:each) do
    FactoryBot.create(:user)
  end

  describe "POST /auto_login" do
    scenario 'valid authorization key attributes' do

      post '/login', params: {
        username: 'example1',
        password: 'example1'
      }
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:user]).to be_present
      expect(json[:token]).to be_present

      token = json[:token] 

      post '/auto_login', nil, {'Authorization' => "bearer #{token}"}
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys
      
      expect(json[:id]).to be_present
    end
  end
end