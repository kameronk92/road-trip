class RoadTripFacade
  def self.get_road_trip(origin, destination)
    data = {}
    # get travel time, convert to unix for forecast
    time_hash = MapquestService.get_travel_time(origin, destination)
    
    travel_time = time_hash[:travel_time]

    unix_travel_time = time_hash[:unix]

    # get arrival coordinates
    coordinates = MapquestService.get_coordinates(destination)

    forecast = WeatherApiService.get_forecast(coordinates, formatted_time)

    data = {
      start_city: origin,
      destination: destination,
      travel_time: travel_time,
      unix_travel_time: unix_travel_time,
      forecast: forecast
    }

    RoadTrip.new(data)
  end
end