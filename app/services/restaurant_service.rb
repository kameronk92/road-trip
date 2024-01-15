class RestaurantService
  def self.get_restaurant(destination, food)
    response = conn.get("/v3/businesses/search?sort_by=best_match&limit=20&location=#{destination}&term=#{food}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com') do |req|
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
  end
end
