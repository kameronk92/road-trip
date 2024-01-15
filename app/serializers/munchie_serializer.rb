class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :destination_city, :forecast, :restaurant
end