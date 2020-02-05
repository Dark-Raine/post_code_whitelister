# README

Prerequisites
1. Ensure you are using ruby version 2.6.1
2. If you don't have bundler run 'gem install bundler'
3. PostgreSQL installed -> https://www.postgresql.org/

Bundler will allow you to install all the other gem dependencies listed in the gem file of this project using the 'bundle install' command in the rails application top level directory.

Ensure your postgreSQL is running locally. in the top level directory you have a few commands to run:

To get the app up and running
1. bundle install
2. rails db:create
3. rails db:migrate
4. rails db:seed

at this point you can run 'rails s' in your terminal which should load up the application and make it servable through localhost. Be sure to check your terminal to get the exact URI.

To access the start point of the app in your browser go to 'localhost/postcodes/new' from here you can start whitelisting postcodes.

To run tests ensure that you have a terminal running the server and then with a second terminal in the same directory run rspec
