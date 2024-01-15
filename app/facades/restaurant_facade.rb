class RestaurantFacade
  def self.get_restaurant(destination, food)
      restaurant = RestaurantService.get_restaurant(destination, food)
      Restaurant.new(restaurant)
    end
  end
end