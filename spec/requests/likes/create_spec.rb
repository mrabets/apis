require 'rails_helper'

RSpec.describe "Likes", type: :request do
  
  before(:each) do
    @user = FactoryBot.create(:user)
    @photo = FactoryBot.create(:photo)  
  end

  describe "POST /api/v1/photos/27/likes" do
    it 'Should like photo' do
      post '/login', params: {
        username: 'example1',
        password: 'example1'
      }
      
      expect(response.status).to eq(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:user]).to be_present
      expect(json[:token]).to be_present

      token = json[:token] 
      
      post "/api/v1/photos/#{@photo.id}/likes", nil, {'Authorization' => "bearer #{token}"}

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:liked]).to eq("true")
    end
  end
end