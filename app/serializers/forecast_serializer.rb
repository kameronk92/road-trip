class ForecastSerializer
  include JSONAPI::Serializer
  attributes :daily_weather, :hourly_weather, :current_weather
end
