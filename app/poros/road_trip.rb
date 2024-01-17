class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(data)
    @id = nil
    @start_city = data[:start_city]
    @end_city = data[:end_city]
    @travel_time = data[:travel_time]
    @weather_at_eta = arrival_forecast(data)
  end

  def arrival_forecast(data)
    
    time_string = data[:arrival_time]
    
    # Extract the arrival hour as an integer
    hour = time_string.hour
    
    # plug hour into forecast
    big_forecast = data[:forecast][:forecast][:forecastday].first[:hour][hour]
    
    {
      temperature: big_forecast[:temp_f],
      datetime: big_forecast[:time],
      condition: big_forecast[:condition][:text]
    }
  end

  # arrival_time = Time.at(Time.now.to_i + unix_travel_time)
end