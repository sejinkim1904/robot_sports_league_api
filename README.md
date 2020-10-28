# Robot Sports League API

Robot Sports League API was built as a backend service that stores data to be displayed in a roster management application. The purpose was to build a tested API that provides authentication and generate player bots for a team to be added to a roster with roles to determine a 'current roster'. 

- Development: http://localhost:3000/api/v1
- Production: https://calm-escarpment-13056.herokuapp.com/api/v1
> Note: there is no graphical user interface for this API so all endpoints must be requested through [Postman](https://www.postman.com/) or similar application.

## Technology and Stack

- [Ruby](https://www.ruby-lang.org/) (see `.ruby-version` for version)
- [Rails 6.0.3.4](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Travis-CI](https://travis-ci.com/)

## Database Diagram

![Screenshot from 2020-10-27 22-40-45](https://user-images.githubusercontent.com/44950896/97391765-909fe300-18a5-11eb-93da-6d903f46028c.png)

## Setup

After you clone this repository, follow these steps to complete your setup:

1. `bundle install` - Install Ruby dependencies.
2. `bundle exec rails db:prepare` - Create database, migrate, and seed.

### Start Server

```shell
$ bundle exec rails server
```

Available endpoints with example reponses can be seen see on [api_calls_responses.md](/docs/api_calls_responses.md)

### Running Tests

To run test suite:

```shell
$ bundle exec rspec
# => Test results shown
```

To check test coverage via [SimpleCov](https://github.com/simplecov-ruby/simplecov) after running tests:

```shell
open coverage/index.html
```

In debian/ubuntu Terminal:

```shell
xdg-open coverage/index.html
```

---

Technical questions answered on [answers_to_technical_questions.md](/docs/answers_to_technical_questions.md)