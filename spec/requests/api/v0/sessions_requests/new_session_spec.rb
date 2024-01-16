require 'rails_helper'

RSpec.describe 'POST /api/v0/sessions', type: :request do
  describe 'happy path' do
    it 'can create a new session' do
      user_params = {
        email: "whatever@example.com",
        "password": "password"
      }

      post '/api/v0/sessions', params: user_params

      expect(response).to be_successful
      expect(response.status).to eq(200)
      response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:data)
      expect(response[:data]).to be_a(Hash)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be("users")
      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)
      expect(response[:data][:attributes]).to have_key(:email)
      expect(response[:data][:attributes][:email]).to be_a(String)
      expect(response[:data][:attributes]).to have_key(:api_key)
      expect(response[:data][:attributes][:api_key]).to be_a(String)
    end
  end
end
