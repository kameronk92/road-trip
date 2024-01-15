require 'rails_helper'

RSpec.describe 'User Create API' do
  describe 'happy path' do
    it 'can create a new user' do
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }

      post '/api/v0/users', params: user_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a(Hash)
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eq("users")
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to be_a(String)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to be_a(Hash)
      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes][:email]).to be_a(String)
      expect(body[:data][:attributes]).to have_key(:api_key)
      expect(body[:data][:attributes][:api_key]).to be_a(String)
    end
  end
end