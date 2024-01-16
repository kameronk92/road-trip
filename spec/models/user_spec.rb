require 'rails_helper'

RSpec.describe 'User model' do
  it 'has attributes' do
    params = {
      email: "email@something.com",
      password: "password",
      password_confirmation: "password"
    }

    user = Users.create!(params)

    expect(user.email).to eq(params[:email])
    expect(user.password_digest).to_not eq(params[:password])
    expect(user.api_key).to_not eq(nil)
  end
end
