require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  let(:user) { create_user }
  let(:photo) { create_photo(user) }
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

    describe 'DELETE /api/v1/photos/:photo_id' do
      context 'when photo exists' do
        before do
          delete "/api/v1/photos/#{photo.id}", headers: headers
        end
    
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns message' do
          expect(response.body)
          .to include("Photo deleted")
        end
      end

      context 'when photo not exists' do
        before do
          delete '/api/v1/photos/1984', headers: headers
        end
    
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
    
        it 'returns message' do
          expect(response.body)
          .to include("Photo not found")
        end
      end
    end
  end
 end