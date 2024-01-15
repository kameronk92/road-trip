class MunchiesFacade
  def self.get_munchies(destination, food)
    forecast = ForecastFacade.get_summary(destination)
    restaurant = RestaurantFacade.get_restaurant(destination, food)
    destination_city = destination
    Munchies.new(destination_city, forecast, restaurant)
  end
end
