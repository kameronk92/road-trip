class BadReviewSerializer
  include JSONAPI::Serializer
    attributes :restaurant_name, :reviews, :rating
end