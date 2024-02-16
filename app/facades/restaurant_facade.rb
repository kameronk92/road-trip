class RestaurantFacade
  def self.get_a_restaurant(destination, food)
    restaurant = RestaurantService.get_restaurant(destination, food)[:businesses][0]
  end
end
