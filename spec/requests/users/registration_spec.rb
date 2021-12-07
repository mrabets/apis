require 'rails_helper'

describe Users::RegistrationsController, type: :request do

  let (:user) { build_user }
  let (:existing_user) { create_user }
  let (:signup_url) { '/users' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 201' do
      expect(response.status).to eq(201)
    end
   
    it 'returns exists id' do
      expect(json['id']).to_not be_nil
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 422' do
      expect(response.status).to eq(422)
    end
  end

end