class RoadTrip
  attr_reader :id, :origin, :destination, :travel_time, :forecast

  def initialize(origin, destination, travel_time, forecast)
    @id = nil
    @origin = origin
    @destination = destination
    @travel_time = travel_time
    @forecast = forecast
  end
end