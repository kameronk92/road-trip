class Api::V1::BadReviewsController < ApplicationController
  def show
    if params[:city].blank? || params[:state].blank? || params[:restaurant_name].blank?
      render json: { error: 'Please provide a destination and search term' }, status: :bad_request
    else
      location = "#{params[:city]},#{params[:state]}" 
      restaurant_name = params[:restaurant_name]

      render json: BadReviewSerializer.new(MunchieFacade.get_bad_reviews(location, restaurant_name))
    end
  end
end
