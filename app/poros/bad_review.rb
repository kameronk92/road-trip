class BadReview
  attr_reader :id, :reviews, :rating, :restaurant_name

  def initialize(data)
    @id = nil
    @reviews = get_reviews(data)
    @rating = get_rating(data)
    @restaurant_name = data[:restaurant_name]
  end

  def get_reviews(data)
    reviews_array = []
    reviews = data[:review_data][:reviews]

    reviews.each do |review|
      reviews_array << review[:text]
    end

    reviews_array
  end

  def get_rating(data)
    ratings_array = []

    reviews = data[:review_data][:reviews]

    reviews.each do |review|
      ratings_array << review[:rating]
    end

    ratings_array.sum / ratings_array.size
  end
end