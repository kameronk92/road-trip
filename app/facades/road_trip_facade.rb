class RoadTripFacade
  def self.get_road_trip(origin, destination)
    # get travel time, convert to unix for forecast
    time_hash = MapquestService.get_travel_time(origin, destination)
    travel_time = time_hash[:travel_time]
    unix_travel_time = time_hash[:unix]
    
    arrival_time = Time.now.to_i + unix_travel_time

    # get arrival coordinates
    coordinates = MapquestService.get_coordinates(destination)

    forecast = WeatherApiService.get_forecast(coordinates, arrival_time)

    RoadTrip.new(origin, destination, travel_time, forecast)
  end
end