# Contalink API

## Description

This API is a simple RESTful API that allows users to pull the invoices from the DB.

## Getting Started

### Prerequisites

- Ruby 3.2.1
- Bundler
- Postgres

### Installation

1. Clone the repo
2. Install the dependencies
   ```sh
   bundle install
   ```
3. Since the DB already exists you need to set up env variables for the DB connection. You can do this by creating
   a `.env` file in the root of the project and adding the following:
    ```.env
      DB_HOST=
      DB_USERNAME=
      DB_NAME=
      DB_PASSWORD=
      DB_PORT=
    ```
   The names of the variables should be as the ones in the `config/database.yml` file.
4. Create the test database
   ```sh
    RAILS_ENV=test bundle exec rails db:create
    ```
5. Run the server
   ```sh
   bundle exec rails s
   ```
6. Run the tests
   ```sh
    bundle exec rspec
    ```
   
## Usage

Open your browser and go to `http://localhost:3000/V1/invoices` to see the invoices. You can also use Postman or any other API client to make a GET request to the same endpoint.
we handle the pagination of 15 invoices.

1. To get the first page of invoices:
   ```sh
   GET http://localhost:3000/V1/invoices
   ```
2. To get the second page of invoices and the following ones, you can use the `page` query parameter like this:
   ```sh
    GET http://localhost:3000/V1/invoices?page=2
    ```
3. To filter by date, you must set the `start_date` and `end_date` query parameters like this:
   ```sh
    GET http://localhost:3000/V1/invoices?start_date=2022-01-01&end_date=2022-01-31
    ```
   