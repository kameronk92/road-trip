class Api::V1::MunchiesController < ApplicationController
  def index
    destination = params[:destination]
    food = params[:food]

    render json: MunchieSerializer.new(MunchieFacade.get_munchies(destination, food))
  end
end
