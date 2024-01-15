require 'rails_helper'

RSpec.describe 'Mapquest Service' do
  it "gets coordinates for a city" do
    VCR.use_cassette('mapquest_data') do
      city = "lihue,hi"
      coordinates = MapquestService.get_coordinates(city)

      expect(coordinates).to be_a(Hash)
      expect(coordinates).to have_key(:lat)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates).to have_key(:lng)
      expect(coordinates[:lng]).to be_a(Float)
    end
  end
end