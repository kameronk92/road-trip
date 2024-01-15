class Munchie
  attr_reader :id, :destination_city, :forecast, :restaurant

  def initialize(destination_city, forecast, restaurant)
    @id = nil
    @destination_city = restaurant_city(restaurant)
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

  def restaurant_city(restaurant)
    "#{restaurant[:location][:city]}, #{restaurant[:location][:state]}"
  end
end
