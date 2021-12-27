require 'rails_helper'
require 'devise/jwt/test_helpers'

describe Users::SessionsController do
  let(:user) { create_user }
  let(:login_url) { '/users/sign_in' }
  let(:logout_url) { '/users/sign_out' }

  context 'when logging in' do
    before do
      login_with_api(user)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns exists id' do
      expect(json['user']).not_to be_nil
    end
  end

  context 'when password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end

    it 'returns the message' do
      expect(json['error']).to eq('Invalid Email or password.')
    end
  end

  context 'when logging out' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

      delete logout_url, headers: auth_headers
    end

    it 'returns 204' do
      expect(response.status).to eq(204)
    end
  end
end
