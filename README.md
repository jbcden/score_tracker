# Score Tracker

- [Local development](#local-development)

## Local development

### Required software

* Ruby 2.7.4
* Ruby on Rails 6.1
* Postgresql 13 or later

### Basic setup

Ensure that you have Postgresql setup. The current default configuration
assumes that there is a postgres user with the same name as the current user
on your machine, if this is not the case, please update the `config/database.yml`
with the correct `username` value.

Once that is set up, run:

```bash
bundle install
bundle exec rails db:create db:migrate db:test:prepare
```

You can verify that everything was set up correctly by running the tests with:

```bash
bundle exec rspec
```

Assuming the tests all pass, you should be able to run:

```bash
bundle exec rails s
```

and begin making requests against the API!

### API examples

For examples of all API requests, please check out our
[docs folder](https://github.com/jbcden/score_tracker/tree/master/docs/apis). If
you like to use Postman to interact with APIs, we also have included an example
collection that can be imported [here](https://github.com/jbcden/score_tracker/tree/master/docs/postman).
