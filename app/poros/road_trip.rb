class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(data)
    @id = nil
    @start_city = data[:origin]
    @end_city = data[:destination]
    @travel_time = data[:travel_time]
    @weather_at_eta = arrival_forecast(forecast)
  end

  def arrival_forecast(forecast)
    forecast_hour = travel
    require 'pry'; binding.pry
  end

  # arrival_time = Time.at(Time.now.to_i + unix_travel_time)
end