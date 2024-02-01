require 'rails_helper'

RSpec.describe 'User Create API' do
  describe 'happy path' do
    it 'can create a new user' do
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }

      post '/api/v0/users', params: user_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a(Hash)
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eq("users")
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to be_a(String)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to be_a(Hash)
      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes][:email]).to be_a(String)
      expect(body[:data][:attributes]).to have_key(:api_key)
      expect(body[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe 'sad paths' do
    it 'returns an error if passwords do not match' do
      user_params = {
        email: "badpass@whatever.com",
        password: "password",
        password_confirmation: "badpassword"
      }
      
      post '/api/v0/users', params: user_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Password and password confirmation must match\"}")
    end

    it 'returns an error if email already exists' do
      user_1_params = {
        email: "whatever@email.com",
        password: "password",
        password_confirmation: "password"
      }

      Users.create(user_1_params)

      user_2_params = user_1_params

      post '/api/v0/users', params: user_2_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"User already exists\"}")
    end

    it 'returns an error if password is missing' do
      user_params = {
        email: "whatever@email.com",
        password: "",
        password_confirmation: "password"
      }

      post '/api/v0/users', params: user_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Enter both password and password confirmation\"}")
    end

    it 'returns an error if password confirmation is missing' do
      user_params = {
        email: "whatever@email.com",
        password: "password",
        password_confirmation: ""
      }

      post '/api/v0/users', params: user_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Enter both password and password confirmation\"}")
    end

    it 'returns an error if email is missing' do
      user_params = {
        email: "",
        password: "password",
        password_confirmation: "password"
      }

      post '/api/v0/users', params: user_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Enter email\"}")
    end

    it 'renders an unknown error when user creation fails' do
      user_params = {
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      allow_any_instance_of(Users).to receive(:save).and_return(false)

      post '/api/v0/users', params: user_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Unknown error occured\"}")
    end
  end
end