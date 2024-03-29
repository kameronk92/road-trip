class RoadTripFacade
  def self.get_road_trip(origin, destination)
    # get travel time, convert to unix for forecast

    time_hash = MapquestService.get_travel_time(origin, destination)

    if time_hash[:travel_time] != nil
      travel_time = time_hash[:travel_time]
      unix_travel_time = time_hash[:unix]

      #format time for forecast request
      arrival_time = Time.at(Time.now.to_i + unix_travel_time)
    else
      travel_time = "impossible"
    end

    # get arrival coordinates
    coordinates = MapquestService.get_coordinates(destination)

    forecast = WeatherApiService.get_forecast(coordinates)

    data = {
      start_city: origin,
      end_city: destination,
      travel_time: travel_time,
      forecast: forecast,
      arrival_time: arrival_time
    }

    RoadTrip.new(data)
  end
end