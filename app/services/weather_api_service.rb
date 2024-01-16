class WeatherApiService
  def self.get_forecast(coordinates, arrival_time = nil)
    response = conn.get('/v1/forecast.json') do |req|
      req.params['q'] = "#{coordinates[:lat]},#{coordinates[:lng]}"
      if arrival_time = nil 
        req.params['days'] = 5
      else
        req.params['dt'] = arrival_time
      end
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
