require 'rails_helper'

RSpec.describe 'restaurant service' do
  it 'returns a single restaurant for a given location' do
    VCR.use_cassette('restaurant_data') do
      restaurants = RestaurantService.get_restaurant('san luis obispo, ca', 'sandwich')

      expect(restaurants).to be_a(Hash)
      expect(restaurants).to have_key(:businesses)
      expect(restaurants[:businesses]).to be_an(Array)
      
      restaurant = restaurants[:businesses][0]
      expect(restaurant).to have_key(:name)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant).to have_key(:location)
      expect(restaurant[:location]).to be_a(Hash)
      expect(restaurant[:location]).to have_key(:display_address)
      expect(restaurant[:location][:display_address]).to be_an(Array)
      expect(restaurant[:location][:display_address][0]).to be_a(String)

      expect(restaurant).to have_key(:rating)
      expect(restaurant[:rating]).to be_a(Float) 
      expect(restaurant).to have_key(:review_count)
      expect(restaurant[:review_count]).to be_a(Integer)
    end
  end
end