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
* ...
