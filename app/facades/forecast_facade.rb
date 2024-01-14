class ForecastFacade
  def self.get_forecast(location)
    # gets current weather and forecast weather for location.
    # returns a Forecast object
    coordinates = MapquestService.get_coordinates(location)
    forecast = WeatherApiService.get_forecast(coordinates)
    Forecast.new(forecast)
  end
end
