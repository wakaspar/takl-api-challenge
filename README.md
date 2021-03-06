# README ~ takl-api-challenge
by Adam Kaspar

## Introduction
 - This application is a simple Rails JSON API that consumes a `provider` UUID, an array of `geo_coordinates` (representing a user's position), and an array of `addresses_attributes` (representing destinations for a delivery route).  The `POST` route returns an optimized list of addresses in order of proximity.  The list is an array and can be iterated through by index.  
 - RSpec is enabled, but not finished.  Current test coverage includes model testing, but request testing is still in development.  
 - I suggest running locally, as I haven't had time to test it in a production environment.

## Usage
- Fork/clone the app.

- Configure PostgreSQL database:
  - $ rails db:setup
  - $ rails db:migrate

- Start Puma server:
  - $ rails s

- You can make requests via Postman. Download Postman here: https://www.postman.com/.  Example request below:
  - In Postman:
    - POST to: `localhost:3000/routes`
    - Include header: `Content-Type` : `application/json`
    - Body(raw):

        ```
        { "route":
        	{
            "provider": "de018897-1613-44a1-acc7-ccfb009249cb",
            "geo_coordinates": [34.98837, -85.1223],
            "addresses_attributes": [
                          {
                            "street_address": "676 Theron Ct",
                            "city": "Pickerington",
                            "state": "Ohio",
                            "zip": "43147"
                          },
                          {
                            "street_address": "1168 Stanyan St",
                            "city": "San Francisco",
                            "state": "California",
                            "zip": "94117"
                          },
                          {
                            "street_address": "59 N Lancaster St",
                            "city": "Athens",
                            "state": "Ohio",
                            "zip": "45701"
                          }
                        ]
          }
        }
        ```

    - Send the request. You should receive an optimized route of addresses in order of proximity as your response.  It should look something like this:

        ```
        [
            {
                "address": "9095, Jenny Lynn Drive, Kesler Hills, East Brainerd, Hamilton County, Tennessee, 37421, United States of America",
                "longitude": 34.98837,
                "latitude": -85.1223
            },
            {
                "address": "59, North Lancaster Street, La Mar Heights, Athens, Athens County, Ohio, 45701, United States of America",
                "longitude": 39.33287391589145,
                "latitude": -82.10500906576705
            },
            {
                "address": "676, Theron Court, Pickerington, Fairfield, Ohio, 43147, United States of America",
                "longitude": 39.87798365306122,
                "latitude": -82.77497173469388
            },
            {
                "address": "1168, Stanyan Street, Cole Valley, San Francisco, California, 94117, United States of America",
                "longitude": 37.7629984,
                "latitude": -122.4521495
            }
        ]
        ```

    - Try adding more addresses to the list for more complex results.
    - *NOTE* ~ Routes are all car-based, and therefore cannot cross continents.
  - In Postman or via browser:
    - Navigate to `localhost:3000/routes` for a full list of all available routes.
    - Navigate to `localhost:3000/routes/:id/addresses` for stored addresses associated to a given Route.
  - Run RSpec tests (all currently implemented should pass):
    $ bundle exec rspec

## Todo
- Refactor RoutesController's `prep_destinations` method to keep `street_addresses` intact.
  - Refactor RoutesController's `generate_user_response` method to reflect changes to `prep_destinations`, eliminating the need to reverse geocode addresses for `@user_response`.
- Get curl requests working (`419 Parse Error`; Bad Request, bug in address data?).
- Finish request specs (RSpec testing).
- Upgrade OS X to migrate to Docker image.

## Ownership
- See the repo: https://www.github.com/wakaspar/takl-api-challenge.
- Please send all questions/feedback/complaints/pizza coupons to mailto:wakaspar@gmail.com.
- Thanks for your consideration and happy coding!
