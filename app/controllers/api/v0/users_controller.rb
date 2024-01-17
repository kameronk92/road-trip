class Api::V0::UsersController < ApplicationController
  def create
    user = Users.new(user_params)

    if params[:password].empty? || params[:password_confirmation].empty?
      render json: { errors: "Enter both password and password confirmation" }, status: :bad_request
    elsif Users.find_by(email: params[:email])
      render json: { errors: "User already exists" }, status: :bad_request
    elsif params[:password_confirmation] != params[:password]
      render json: { errors: "Password and password confirmation must match" }, status: :bad_request
    elsif params[:email].empty?
      render json: { errors: "Enter email" }, status: :bad_request
    elsif user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { errors: "Unknown error occured" }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
