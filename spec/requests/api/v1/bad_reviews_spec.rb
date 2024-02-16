require 'rails_helper.rb'

RSpec.describe 'Bad Reviews API' do
  describe 'happy  path' do
    describe 'bad reviews get requests' do
      it 'returns 3 bad reviews with details for the resulting restaurant' do 
        VCR.use_cassette('bad_reviews_request_data') do 
        get '/api/v1/bad_reviews?city=pueblo&state=co&restaurant_name=Elzars'

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:data)
        expect(response_body[:data]).to be_a(Hash)
        expect(response_body[:data]).to have_key(:id)
        expect(response_body[:data][:id]).to eq(nil)
        expect(response_body[:data]).to have_key(:type)
        expect(response_body[:data][:type]).to eq('bad_review')
        end
      end
    end
  end
end