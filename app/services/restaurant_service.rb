class RestaurantService
  def self.get_restaurant(destination, food)
    response = conn.get("/v3/businesses/search?sort_by=best_match&limit=1&location=#{destination}&term=#{food}")
    #felt ok to limit results to 1 for this assignment, but it is also limited in the RestaurantFacade
     body = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_cracker_barrel_reviews(location)
    # get cracker barrel reviews
      # find a local cracker barrel, take yelp_id
      # go back to yelp and get cracker barrel reviews
    response = conn.get("/v3/businesses/search?sort_by=best_match&limit=1&location=#{location}&term=crackerbarrel")
    #felt ok to limit results to 1 for this assignment, but it is also limited in the RestaurantFacade
    cracker_barrrel_yelp_id = JSON.parse(response.body, symbolize_names: true)[:businesses][0][:id]

    response = conn.get("/v3/businesses/#{cracker_barrrel_yelp_id}/reviews")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com') do |req|
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
  end
end
