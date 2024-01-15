require 'rails_helper'

RSpec.describe 'Munchies API' do 
  describe 'happy path' do
    describe 'GET /api/v1/munchies?destination=pueblo,co&food=italian' do
      it 'returns a forecast and a restaurant for a given location' do
        VCR.use_cassette('munchies_request_data') do
          get '/api/v1/munchies?destination=pueblo,co&food=italian'

          response_body = JSON.parse(response.body, symbolize_names: true)
          
          require 'pry'; binding.pry
        end
      end
    end
  end
end