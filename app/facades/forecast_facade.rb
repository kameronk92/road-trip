class ForecastFacade
  def self.get_forecast(location)
    # gets current weather and forecast weather for location.
    # returns a Forecast object
    coordinates = MapquestService.get_coordinates(location)
    forecast = WeatherApiService.get_forecast(coordinates)
    Forecast.new(forecast)
  end

  def self.get_summary(location)
    # gets current weather and forecast weather for location.
    # returns a Forecast object
    coordinates = MapquestService.get_coordinates(location)
    forecast = WeatherApiService.get_forecast(coordinates)
    Forecast.new(forecast).summary(forecast)
    # I think there is a better way to do this but am crunched for time
  end
end
