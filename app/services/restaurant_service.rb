class RestaurantService
  def self.get_restaurant(destination, food)
    response = conn.get("/v3/businesses/search?sort_by=best_match&limit=1&location=#{destination}&term=#{food}")
    #felt ok to limit results to 1 for this assignment, but it is also limited in the RestaurantFacade
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com') do |req|
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
  end
end
