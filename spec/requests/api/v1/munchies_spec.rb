require 'rails_helper'

RSpec.describe 'Munchies API' do 
  describe 'happy path' do
    describe 'GET /api/v1/munchies?destination=pueblo,co&food=italian' do
      it 'returns a forecast and a restaurant for a given location' do
        VCR.use_cassette('munchies_request_data') do
          get '/api/v1/munchies?destination=pueblo,co&food=italian'

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful
          expect(response.status).to eq(200)

          expect(response_body).to be_a(Hash)
          expect(response_body).to have_key(:data)
          expect(response_body[:data]).to be_a(Hash)
          expect(response_body[:data]).to have_key(:id)
          expect(response_body[:data][:id]).to eq(nil)
          expect(response_body[:data]).to have_key(:type)
          expect(response_body[:data][:type]).to eq('munchie')
          
          expect(response_body[:data]).to have_key(:attributes)
          expect(response_body[:data][:attributes]).to be_a(Hash)
          expect(response_body[:data][:attributes]).to have_key(:destination_city)
          expect(response_body[:data][:attributes][:destination_city]).to be_a(String)
          
          expect(response_body[:data][:attributes]).to have_key(:forecast)
          expect(response_body[:data][:attributes][:forecast]).to be_a(Hash)
          expect(response_body[:data][:attributes][:forecast]).to have_key(:summary)
          expect(response_body[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(response_body[:data][:attributes][:forecast]).to have_key(:temperature)
          expect(response_body[:data][:attributes][:forecast][:temperature]).to be_a(String)

          expect(response_body[:data][:attributes]).to have_key(:restaurant)
          expect(response_body[:data][:attributes][:restaurant]).to be_a(Hash)
          expect(response_body[:data][:attributes][:restaurant]).to have_key(:name)
          expect(response_body[:data][:attributes][:restaurant][:name]).to be_a(String)
          expect(response_body[:data][:attributes][:restaurant]).to have_key(:address)
          expect(response_body[:data][:attributes][:restaurant][:address]).to be_a(String)
          expect(response_body[:data][:attributes][:restaurant]).to have_key(:rating)
          expect(response_body[:data][:attributes][:restaurant][:rating]).to be_a(Float)
          expect(response_body[:data][:attributes][:restaurant]).to have_key(:reviews)
          expect(response_body[:data][:attributes][:restaurant][:reviews]).to be_a(Integer)
        end
      end
    end
  end
end