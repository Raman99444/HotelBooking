# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    **Rails :** Rails 7.0.8.4
    **Ruby :** ruby 3.2.0
* System dependencies

* Configuration

* Database creation

    We are utilizing MongoDB in this project. It would be beneficial to set up MongoDB Atlas and obtain the connection string to include in the mongoid.yml file. For example:

    **uri:** "mongodb+srv://<USERNAME>:<PASSWORD>@cluster0.5cec0ps.mongodb.net/hotel_booking_app_development?retryWrites=true&w=majority"

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Local Setup Instructions

    Clone the code from the repository using the following link: o https://github.com/Raman99444/HotelBooking and you can use the SSH URL: (git@github.com:Raman99444/HotelBooking.git)

    Run the command `bundle install` to install the necessary dependencies.

    Add a secret key for JWT in your Rails credentials. For example, open the credentials with an editor (e.g., `EDITOR="vim" bin/rails credentials:edit`) and add the secret key as shown below:

    devise:
        jwt_secret_key: <your_secret_key>

    Configured MongoDB as described in the `Database Creation` section.

    I have deployed the changes to Heroku. You can walk through the application using the following URL: `https://hotelbookingcendyn-4394e0b652ed.herokuapp.com` instead of setting it up locally.

    **API Test:**

    To test the APIs using Postman or any other service, follow the procedure below.

    Before starting to test the APIs, set the `Accept` header to `application/json`.

    *User Signup:*

    **POST** `http://localhost:3000/users` with the required user details to create a new user. The request should look something like this:

    ``{
        "user": {
            "email": "testinguserlast@example.com",
            "password": "password",
            "password_confirmation": "password"
        }
    }``

    The response should include the created user details along with token information. It should look like this:

    ``{
        "_id": {
            "$oid": "6689277a776ac94d47bd834d"
        },
        "address": null,
        "birthday": null,
        "created_at": "2024-07-06T11:16:10.123Z",
        "email": "testinguserlast@example.com",
        "gender": null,
        "jti": "<TOKEN>",
        "name": "Testing User last",
        "pincode": null,
        "state": null,
        "updated_at": "2024-07-06T14:49:14.512Z"
    }``

    *Sign_in API*

    **POST** `http://localhost:3000/users/sign_in` Use this API endpoint to sign in with your user credentials. For example:

    ``{
        "user": {
            "email": "testinguserlast@example.com",
            "password": "password"
        }
    }``

    You will receive a response containing user details and token information. For example:

    ``{
        "_id": {
            "$oid": "6689277a776ac94d47bd834d"
        },
        "address": null,
        "birthday": null,
        "created_at": "2024-07-06T11:16:10.123Z",
        "email": "testinguserlast@example.com",
        "gender": null,
        "jti": "1323a6aa-a9ca-4436-ab3e-ae249450513e",
        "name": "Testing User last",
        "pincode": null,
        "state": null,
        "updated_at": "2024-07-06T14:49:14.512Z"
    }``

    From the above response, copy the `jti` (which is the bearer token) and set it in the Bearer Token field under the authorization section for further API calls.

    *Fetch User Bookings*

    **GET** `http://localhost:3000/my_bookings` To retrieve user booking details, use this API. If there are any bookings, you will receive all the booking details; otherwise, you will receive an empty array.

    *Create a New Bookings*

    **POST** `http://localhost:3000/bookings` To create new bookings, use this API. Provide the required details in the request. For example:

    ``{
        "booking": {
            "hotel_name": "Hotel AA1",
            "price": "250",
            "currency": "USD",
            "arrival_date": "2024-07-07",
            "departure_date": "2024-07-10",
            "guest_name": "Guest A",
            "guest_email": "guesta@example.com"
        }
    }``

    Once you create the booking, you will receive a response like the one below:

    ``{
        "_id": {
            "$oid": "668a172f3cf555381f0f0f5a"
        },
        "arrival_date": "2024-07-07",
        "created_at": "2024-07-07T04:18:55.664Z",
        "currency": "USD",
        "departure_date": "2024-07-10",
        "guest_email": "guesta@example.com",
        "guest_name": "Guest A",
        "hotel_name": "Hotel AA1",
        "price": 250.0,
        "updated_at": "2024-07-07T04:18:55.664Z",
        "user_id": {
            "$oid": "6689277a776ac94d47bd834d"
        }
    }``

    *Edit Bookings*

    **GET** `http://localhost:3000/bookings/<booking_id>/edit` Use this API to edit specific bookings.

    **PATCH** `http://localhost:3000/bookings/<booking_id>` Use this API to update the specific bookings.

    **DELETE** `http://localhost:3000/bookings/<booking_id>` Use this API to delete the specific bookings.

* ...
