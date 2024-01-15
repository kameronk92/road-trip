class Munchies
  attr_reader :destination_city, :forecast, :restaurant

  def initialize(destination_city, forecast, restaurant)
    @destination_city = destination_city
    @forecast = forecast
    @restaurant = restaurant
  end
end