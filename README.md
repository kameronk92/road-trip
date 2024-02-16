# README

This project completed by a Mod 3 student at Turing School.

The prompt for the project can be found [here](https://backend.turing.edu/module3/projects/sweater_weather/index)

### Learning Goals For This Project
* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## Let's take a trip!
Sweater weather can be used to get restaurant recommendations in a specified city. It also has an endpoint to let you know the temperature when you arrive. Follow the steps below to run the app locally. 

### Setup
* Clone or fork and clone this repository
* `bundle install`
* `rails:db { drop, create, migrate, seed }`
* `bundle exec rspec`
* You should see 16 passing tests and 100% coverage
* Run `rails s` and try your own requests in *Postman* or a similar application.

## Check the weather
The app can check the weather for you before you decide to venture off. 
#### Sample request
```
GET /api/v0/forecast?location=cincinatti,oh
Content-Type: application/json
Accept: application/json
```
#### Sample response
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}
```

## User database
Users can register with SweaterWeather, and the app will issue them a unique, secure API key. Then they are able to log in. 
### Generating your own API key
While the app is running in your local server, send a request similar to the following. The response includes a unique API Key to be used in **Road Trip** requests.

#### Sample User Post Request
```
POST /api/v0/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
#### Sample User Post Response
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

## Logging In
If a user forgot their API key, they can send a login request and see their key in the response. 

### Sample request
```
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```
### Sample response
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

## Are we there yet??
Finally, users can use their unique, secure API key to check the forecasted weather in their destination, when they are expected to arrive. 

### Sample request
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```
### Sample response
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```

### Get a restaurant recommendation
*this branch in development*
