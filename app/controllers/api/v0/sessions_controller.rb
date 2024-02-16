class Api::V0::SessionsController < ApplicationController
  def create
    user = Users.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end
  end
end
