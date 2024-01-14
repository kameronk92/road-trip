require 'rails_helper'

RSpec.describe 'Weather API Service' do
  it "gets forecast for a city" do
    VCR.use_cassette('forecast_data') do
      coordinates = {lat: 39.738453, lng: -104.984853}

      data = WeatherApiService.get_forecast(coordinates)

      #test current weather data
      current_weather = data[:current]
      expect(current_weather).to have_key(:last_updated)
      expect(current_weather).to have_key(:temp_f)
      expect(current_weather).to have_key(:feelslike_f)
      expect(current_weather).to have_key(:humidity)
      expect(current_weather).to have_key(:uv)
      expect(current_weather).to have_key(:vis_miles)
      expect(current_weather).to have_key(:condition)
      expect(current_weather[:condition]).to be_a(Hash)
      expect(current_weather[:condition]).to have_key(:text)
      expect(current_weather[:condition]).to have_key(:icon)
      
      #test forecast data
      expect(data[:forecast][:forecastday].count).to eq(5)
      forecast = data[:forecast][:forecastday][0]
      expect(forecast).to have_key(:date)
      expect(forecast).to have_key(:astro)
      expect(forecast[:astro]).to be_a(Hash)
      expect(forecast[:astro]).to have_key(:sunrise)
      expect(forecast[:astro]).to have_key(:sunset)
      expect(forecast).to have_key(:day)
      expect(forecast[:day]).to be_a(Hash)
      expect(forecast[:day]).to have_key(:maxtemp_f)
      expect(forecast[:day]).to have_key(:mintemp_f)
      expect(forecast[:day]).to have_key(:condition)
      expect(forecast[:day][:condition]).to be_a(Hash)
      expect(forecast[:day][:condition]).to have_key(:text)
      expect(forecast[:day][:condition]).to have_key(:icon)

      #test hourly data
      hourly = data[:forecast][:forecastday][0][:hour]
      expect(hourly.count).to eq(24)
      expect(hourly[0]).to have_key(:time)
      expect(hourly[0]).to have_key(:temp_f)
      expect(hourly[0]).to have_key(:condition)
      expect(hourly[0][:condition]).to be_a(Hash)
      expect(hourly[0][:condition]).to have_key(:text)
      expect(hourly[0][:condition]).to have_key(:icon)
    end
  end
end