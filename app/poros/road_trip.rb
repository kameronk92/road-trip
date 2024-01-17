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
    if data[:travel_time] == "impossible"
      @weather_at_eta = {}
    else
      time_string = data[:arrival_time]
      
      # Extract the arrival hour as an integer
      hour = time_string.hour
      
      # plug hour into forecast
      arrival_hour_forecast = data[:forecast][:forecast][:forecastday].first[:hour][hour]

      {
        #
        temperature: arrival_hour_forecast[:temp_f],
        datetime: arrival_hour_forecast[:time],
        condition: arrival_hour_forecast[:condition][:text]
      }
    end
  end
end
