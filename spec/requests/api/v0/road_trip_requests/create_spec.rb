require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  describe 'Happy Path' do
    it 'returns road trip information' do
      VCR.use_cassette 'Road Trip Happy' do 
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }

        user = Users.create(user_params)

        road_trip_params = {
          "origin": "Cincinatti,OH",
          "destination": "Chicago,IL",
          "api_key": user.api_key
        }

        post '/api/v0/road_trip', params: road_trip_params, as: :json

        require 'pry'; binding.pry
        expect(response).to be_successful
        expect(response.status).to eq(200)

      end
    end
  end
end