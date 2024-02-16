class MunchieFacade
  def self.get_munchies(destination, food)
    forecast = ForecastFacade.get_summary(destination)
    restaurant = RestaurantFacade.get_a_restaurant(destination, food)
    destination_city = destination
    Munchie.new(destination_city, forecast, restaurant)
  end

  def self.get_bad_reviews(location, restaurant_name)

    # get cracker barrel reviews
      # find a local cracker barrel, take yelp_id
      # go back to yelp and get cracker barrel reviews
    # assign to search restaurant
    review_data = RestaurantService.get_cracker_barrel_reviews(location)

    data = {restaurant_name: restaurant_name, review_data: review_data}
    
    BadReview.new(data)
  end
end
