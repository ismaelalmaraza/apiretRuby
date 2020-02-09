# Tinnova Api Test

Welcome!

In this test, you will have to prove your full stack skills' worth, by building an API which has to meet certain criteria.

Read carefully the instructions, as they contain all the details regarding this evaluation.

We've already started a project for you, so it's easier to work with.

* Ruby version
  2.6.0

* Rails version
  5.2

### Authentication
The user authentication is already managed with JWT. For every request regarding beers, you'll need to attach the token generated with the `login` method as a header. The controller already contains an instance variable called `@current_user` which is an `User` object extracted from Database.

For you to login, you need to make a **POST** request to the route `/auth/login`, with the json:
```
user: {
  username: 'username',
  password: 'password'
}
```

The JSON response will contain a token, which you will use to authenticate the user on every request.

The authentication header **MUST** be in the format:
```
Authorization: Bearer {token}
```
In any other case, the application will throw an error.

The project's seeds already come with an `admin` user for creation, but feel free to add any user's you'd like.

## Your challenge

Your challenge will be to build a small beer-centered API through Ruby on Rails. The first information set will be taken from an open API, found (here)[https://punkapi.com/documentation/v2].

The (Punk API)[https://punkapi.com/documentation/v2] is a beer API list, which responds with JSON, and contains relevant beer information.

The user, must be able to get all beers, showing only relevant information:

* id
* name
* tagline
* description
* abv

Of course, the user should be able to filter by `name` or by `abv`.

When a user has seen a beer (shown/processed by the API), it **MUST** be saved in a `Beers` table, with the `date` and `time` the user saw it. When showing the beer list, the field `seen_at` should contain the information.

You have to generate the `Beers` model & migration.

Keep in mind that as a user, I don't want to know when other users have seen a beer. If I haven't seen it and others have, I wouldn't know.

After I've seen quite a list of beers, I, as a user, would like to save one as my favorite.

Create an endpoint that will save the beer as my favorite. By creating the endpoint, you need to create the route, migration and model.

I also want to be able to retrieve my favorite beer. So, create an endpoint to `get` it.

My favorite beer should be seen in the `get all` beers endpoint, with the property `favorite: true`.

Place all endpoint operations inside the `beer` controller.

Again, keep in mind, that I do **NOT** want to know anyone else's favorite beer, only mine.

All responses **MUST** be in `JSON` format, and will be tested with Postman.

You have 24 hours to finish this task. Good luck, and may the force be with you.

If you come up with **ANY** doubts, do **NOT** hesitate to ask, as you have limited time to finish. As soon as you don't understand somethig, please just ask.

## Extra Credit

Install RSpec and use it to write out tests for your application. Write as many as you consider appropiate.

### HTTP Requests

A `gem` called `faraday` comes already installed with the project. But feel free to use any HTTP client.

The documentation for `faraday` can [be found here](https://github.com/lostisland/faraday).

## Setup

For this to work you need to install PostgreSQL database in your computer and start a server.

You'll need Ruby v2.6.0 and Rails v5.2.

Clone the project, and create your branch. Use any name you'd like. We recommend you using something like `{name}_test_solution`.

Install dependencies:
```
bundle install
```

Create database and migrate the changes:
```
rake db:create
rake db:migrate
```

Seed the `User` data to the database:
```
rake db:seed
```

Run the projects
```
rails s
```
