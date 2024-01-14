class Forecast
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @type = "forecast"
    @current_weather = current(data)
    @daily_weather = daily(data)
    @hourly_weather = hourly(data)
  end

  def current(data)
    {
      last_updated: data[:current][:last_updated],
      temperature: data[:current][:temp_f],
      feels_like: data[:current][:feelslike_f],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uv],
      visibility: data[:current][:vis_miles],
      condition: data[:current][:condition][:text],
      icon: data[:current][:condition][:icon]
    }
  end

  def daily(data)
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

  def hourly(data)
    data[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
