class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination_city, :forecast, :restaurant
end