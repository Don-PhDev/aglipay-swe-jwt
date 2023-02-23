# Rails E-Commerce Application

This is a Ruby on Rails E-Commerce application with features for managing products, orders, users, and payments. It uses JWT for user authentication and has API endpoints for performing CRUD operations on products and purchasing products. Products are organized into categories and there is an active admin console for managing orders, products, categories, and users.

## Requirements

Create an E-Commerce application with the option to manage products, orders, users, and payments.

- Use JWT for user authentication
- Create API endpoints to perform CRUD operations on products
- Create endpoints to purchase a product
- Products need to be divided into categories
- Setup an active admin console for performing CRUD operations on orders, products, categories and users
- Use RSpec for writing unit tests

## Installation

Clone this repository:
```bash
git clone https://github.com/Don-PhDev/aglipay-swe-jwt.git
```

Install the required gems:
```bash
bundle install
```

Create the database and run the migrations:
```bash
rails db:create
rails db:migrate
```

Seed the database with initial data:
```bash
rails db:seed
```

Start the server:
```bash
rails server
```
    
## Usage/Examples

### Register a User
To register a new user, send a `POST` request to `/api/v1/users` with the following parameters:

- `email`
- `password`
- `password_confirmation`

Using Postman or your favourite software testing API platform

```perl
{
  "user": {
    "email": "example@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
}
```

or you can use cURL command like this:

```bash
curl -H "Content-Type: application/json" -X POST -d '{"user": {"email": "example@example.com", "password": "password", "password_confirmation": "password"}}' http://localhost:3000/users
```

### Login a User
To log in a user, send a `POST` request to `/api/v1/login` with the following parameters:
- `email`
- `password`

```perl
{
  "user": {
    "email": "example@example.com",
    "password": "password"
  }
}
```

```bash
curl -i -H "Content-Type: application/json" -X POST -d '{"user": {"email": "example@example.com", "password": "password"}}' http://localhost:3000/users/sign_in
```

This will return a JWT token that should be included in the headers of subsequent requests.

### Logout a User
To log out a user, send a `DELETE` request to `/api/v1/logout`.

```bash
curl -H "Content-Type: application/json" -X DELETE -d '' -H 'Authorization: <AUTH_TOKEN>' http://localhost:3000/users/sign_out
```

**Note**: Replace `<AUTH_TOKEN>` with the user's authentication token.

### Check If Logged In
To check if a user is logged in, send a `GET` request to `/users/member-data` with the user's authentication token in the Authorization header:

```bash
curl -H "Content-Type: application/json" -H 'Authorization: <AUTH_TOKEN>' http://localhost:3000/users/member-data
```

**Note**: Replace `<AUTH_TOKEN>` with the user's authentication token.

***

### Create a Product
Send a `POST` request to `/api/v1/products` with the following parameters:

- `name`
- `price`
- `category_id`

Include the JWT token in the headers of the request.

### Update a Product
Send a `PUT` request to `/api/v1/products/:id` with the following parameters:

- `name`
- `price`
- `category_id`

Include the JWT token in the headers of the request.

### Delete a Product
Send a `DELETE` request to `/api/v1/products/:id`.

Include the JWT token in the headers of the request.

### Purchase a Product
Send a `POST` request to `/api/v1/orders` with the following parameters:

- `product_id`
- `quantity`
Include the JWT token in the headers of the request.

***

### Admin Console
To access the admin console, go to `/admin`.

