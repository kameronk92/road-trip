class WeatherApiService
  def self.get_current_weather(coordinates)
    response = conn.get('/v1/current.json') do |req|
      req.params['q'] = "#{coordinates[:lat]},#{coordinates[:lng]}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_forecast(coordinates)
    response = conn.get('/v1/forecast.json') do |req|
      req.params['q'] = "#{coordinates[:lat]},#{coordinates[:lng]}"
      req.params['days'] = 5
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('http://api.weatherapi.com') do |req|
      req.params['key'] = Rails.application.credentials.weather_api[:key]
    end
  end
end
