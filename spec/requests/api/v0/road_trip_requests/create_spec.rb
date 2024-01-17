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

        expect(response).to be_successful
        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to have_key(:data)
        expect(data[:data]).to have_key(:id)
        expect(data[:data][:id]).to eq(nil)
        expect(data[:data]).to have_key(:type)
        expect(data[:data][:type]).to eq("road_trip")
        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to be_a(Hash)
  
        attributes = data[:data][:attributes]

        expect(attributes).to have_key(:start_city)
        expect(attributes[:start_city]).to be_a(String)
        expect(attributes).to have_key(:end_city)
        expect(attributes[:end_city]).to be_a(String)
        expect(attributes).to have_key(:travel_time)
        expect(attributes[:travel_time]).to be_a(String)
        expect(attributes).to have_key(:weather_at_eta)
        expect(attributes[:weather_at_eta]).to be_a(Hash)

        weather_at_eta = attributes[:weather_at_eta]

        expect(weather_at_eta).to have_key(:temperature)
        expect(weather_at_eta[:temperature]).to be_a(Float)
        expect(weather_at_eta).to have_key(:condition)
        expect(weather_at_eta[:condition]).to be_a(String)
        expect(weather_at_eta).to have_key(:datetime)
        expect(weather_at_eta[:datetime]).to be_a(String)
      end
    end
  end

  describe 'Sad Path' do
    it 'weather block should be empty and travel time should be “impossible” if the trip is impossible' do
      VCR.use_cassette 'Road Trip Sad' do
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

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)

      end
    end
  end
end