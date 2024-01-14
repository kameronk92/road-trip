class Forecast
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @type = "forecast"
    @current_weather = current_weather(data)
    @daily_weather = daily_weather(data)
    @hourly_weather = hourly_weather(data)
  end

  # def forecast_attributes(data)
  #   {
  #     current_weather: current_weather(data),
  #     daily_weather: daily_weather(data),
  #     hourly_weather: hourly_weather(data)
  #   }
  # end

  def current_weather(data)
    {
      last_updated: data[:current][:last_updated],
      temp_f: data[:current][:temp_f],
      feelslike_f: data[:current][:feelslike_f],
      humidity: data[:current][:humidity],
      uv: data[:current][:uv],
      vis_miles: data[:current][:vis_miles],
      condition: data[:current][:condition]
    }
  end

  def daily_weather(data)
    data[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather(data)
    data[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: hour[:time],
        temp: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
