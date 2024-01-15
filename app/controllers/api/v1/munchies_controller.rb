class API::V1::MunchiesController < ApplicationController
  def index
    destination = params[:destination]
    food = params[:food]

    render json: MunchiesSerializer.new(MunchiesFacade.get_munchies(destination, food))
  end
end
