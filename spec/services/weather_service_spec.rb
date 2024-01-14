require 'rails_helper'

RSpec.describe 'Weather API Service' do
  it "gets current weather for a city" do
    coordinates = {lat: 39.738453, lng: -104.984853}

    current_weather = WeatherApiService.get_current_weather(coordinates)

    expect(current_weather).to be_a(Hash)
    expect(current_weather).to have_key(:current)
    expect(current_weather[:current]).to be_a(Hash)

    data = current_weather[:current]
    expect(data).to have_key(:last_updated)
    expect(data).to have_key(:temp_f)
    expect(data).to have_key(:feelslike_f)
    expect(data).to have_key(:humidity)
    expect(data).to have_key(:uv)
    expect(data).to have_key(:vis_miles)
    expect(data).to have_key(:condition)
    expect(data[:condition]).to be_a(Hash)
    expect(data[:condition]).to have_key(:text)
    expect(data[:condition]).to have_key(:icon)
  end

  it "gets forecast for a city" do
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
    expect(forecast).to have_key(:day)
    expect(forecast[:day]).to be_a(Hash)
    expect(forecast[:day]).to have_key(:astro)
    expect(forecast[:day][:astro]).to be_a(Hash)
    expect(forecast[:day][:astro]).to have_key(:sunrise)
    expect(forecast[:day][:astro]).to have_key(:sunset)
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