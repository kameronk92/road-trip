class Api::V1::MunchiesController < ApplicationController
  def index
    if params[:destination].blank? || params[:food].blank?
      render json: { error: 'Please provide a destination and food type' }, status: :bad_request
    else
      destination = params[:destination]
      food = params[:food]

      render json: MunchieSerializer.new(MunchieFacade.get_munchies(destination, food))
    end
  end
end
