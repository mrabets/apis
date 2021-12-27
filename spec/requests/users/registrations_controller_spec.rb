require 'rails_helper'

describe Users::RegistrationsController, type: :request do
  let(:user) { build_user }
  let(:existing_user) { create_user }
  let(:signup_url) { '/users' }

  context 'when creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password,
          password_confirmation: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns exists id' do
      expect(json['user']).not_to be_nil
    end
  end

  context 'when an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password,
          password_confirmation: user.password
        }
      }
    end

    it 'returns 422' do
      expect(response.status).to eq(422)
    end
  end
end
