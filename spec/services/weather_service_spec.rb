require 'rails_helper'

RSpec.describe 'Weather API Service' do
  it "gets current weather for a city" do
    coordinates = {lat: 39.738453, lng: -104.984853}

    current_weather = WeatherApiService.get_current_weather(coordinates)
  end
end