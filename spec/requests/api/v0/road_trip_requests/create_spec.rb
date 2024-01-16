require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  describe 'Happy Path' do
    it 'returns road trip information' do
      road_trip_params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
      }

      post 'api/v0/road_trip', params: road_trip_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      
    end
  end
end