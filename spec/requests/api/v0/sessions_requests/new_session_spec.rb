require 'rails_helper'

RSpec.describe 'POST /api/v0/sessions', type: :request do
  describe 'happy path' do
    it 'can create a new session' do
      new_user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
      session_user_params = {
        email: "whatever@example.com",
        password: "password",
      }

      Users.create!(new_user_params)

      post '/api/v0/sessions', params: session_user_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to be_a(Hash)
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to be_a(String)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to be("users")
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to be_a(Hash)
      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes][:email]).to be_a(String)
      expect(body[:data][:attributes]).to have_key(:api_key)
      expect(body[:data][:attributes][:api_key]).to be_a(String)
    end
  end
end
