class Api::V0::RoadTripsController < ApplicationController
  def create
    if Users.find_by(api_key: params[:api_key]).nil?
      render json: { errors: "Invalid API key" }, status: :unauthorized
    else
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      if road_trip.travel_time == "impossible"
        render json: RoadTripSerializer.new(road_trip), status: :bad_request
      else
        render json: RoadTripSerializer.new(road_trip), status: :ok
      end
    end
  end
end