class Munchie
  attr_reader :destination_city, :forecast, :restaurant

  def initialize(destination_city, forecast, restaurant)
    @destination_city = destination_city
    @forecast = forecast
    @restaurant = restaurant_details(restaurant)
  end

  def restaurant_details(restaurant)
    { 
      name: restaurant[:name],
      address: restaurant[:location][:display_address][0],
      rating: restaurant[:rating],
      reviews: restaurant[:review_count]
    }
  end
end
