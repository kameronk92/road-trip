class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if params[:password_confirmation] != params[:password]
      render json: { errors: "Password and password confirmation must match" }, status: :bad_request
    elsif User.find_by(email: params[:email])
      render json: { errors: "Email already exists" }, status: :bad_request
    elsif params[:password].nil? || params[:password_confirmation].nil?
      render json: { errors: "Enter both password and password confirmation" }, status: :bad_request
    elsif params[:email].nil?
      render json: { errors: "Enter email" }, status: :bad_request
    elsif user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
