require 'rails_helper'

RSpec.describe 'Forecast API' do
  it "sends detailed forecast data for a city" do
    VCR.use_cassette('forecast_data') do
    
    get api_v0_forecast_path, params: {location: "denver,co"}

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)
    # test top level keys
    require 'pry'; binding.pry
    expect(forecast).to have_key(:data)
    data = forecast[:data]
    expect(data).to have_key(:id)
    expect(data[:id]).to eq(nil)
    expect(data).to have_key(:type)
    expect(data[:type]).to eq("forecast")
    expect(data).to have_key(:attributes)

    # test attributes top level keys
    attributes = data[:attributes]
    require 'pry'; binding.pryq
    expect(attributes).to have_key(:current_weather)
    expect(attributes).to have_key(:daily_weather)
    expect(attributes).to have_key(:hourly_weather)
    
    # test current_weather
    current_weather = attributes[:current_weather]
    expect(current_weather).to have_key(:last_updated)
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather[:uvi]).to be_a(Float)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather).to have_key(:condition)
    expect(current_weather[:condition]).to be_a(String)
    expect(current_weather).to have_key(:icon)
    expect(current_weather[:icon]).to be_a(String)
    
    #test daily_weather
    expect(attributes[:daily_weather]).to be_an(Array)
    daily_weather = attributes[:daily_weather][0]
    expect(daily_weather).to have_key(:date)
    expect(daily_weather[:date]).to be_a(String)
    expect(daily_weather).to have_key(:sunrise)
    expect(daily_weather[:sunrise]).to be_a(String)
    expect(daily_weather).to have_key(:sunset)
    expect(daily_weather[:sunset]).to be_a(String)
    expect(daily_weather).to have_key(:max_temp)
    expect(daily_weather[:max_temp]).to be_a(Float)
    expect(daily_weather).to have_key(:min_temp)
    expect(daily_weather[:min_temp]).to be_a(Float)
    expect(daily_weather).to have_key(:condition)
    expect(daily_weather[:condition]).to be_a(String)
    expect(daily_weather).to have_key(:icon)
    expect(daily_weather[:icon]).to be_a(String)

    #test hourly_weather
    expect(attributes[:hourly_weather]).to be_an(Array)
    hourly_weather = attributes[:hourly_weather][0]
    expect(hourly_weather).to have_key(:time)
    expect(hourly_weather[:time]).to be_a(String)
    expect(hourly_weather).to have_key(:temperature)
    expect(hourly_weather[:temperature]).to be_a(Float)
    expect(hourly_weather).to have_key(:condition)
    expect(hourly_weather[:condition]).to be_a(String)
    expect(hourly_weather).to have_key(:icon)
    expect(hourly_weather[:icon]).to be_a(String)
    end
  end
end