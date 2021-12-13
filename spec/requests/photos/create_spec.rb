require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Photos', type: :request do
  let(:photo) { build_photo }
  let(:user) { create_user }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/photos' do
    
    before do
      get '/api/v1/photos', headers: headers
    end

    it 'returns photos' do
      expect(json).not_to be_nil
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/photos' do  
    context 'when the request is valid' do

      before do
        post '/api/v1/photos', headers: headers, 
                               params: { name: "Valid Photo Name" }.to_json
      end

      it 'creates a photo' do
        expect(json['name']).to eq('Valid Photo Name')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/api/v1/photos', headers: headers, 
                               params: { name: "" }.to_json
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
       .to include("is too short (minimum is 1 character)")
      end
    end
  end
 end