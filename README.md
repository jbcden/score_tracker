# Score Tracker

- [Local development](#local-development)
- [Developing with Docker](#developing-with-docker)

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

<a name=‘developing-with-docker’></a>
## Developing with Docker

### Install Docker

Download and install Docker; see https://docs.docker.com/docker-for-mac/install/ for macos.

### Run the app with docker compose

To use this setup, first replace `config/database.yml` with `config/docker-compose-database.yml`.

Then run the following:

`$ docker-compose up`

The first build will take several minutes, but subsequent builds should be fast. When everything works as expected, you should see db and web containers running.

Open another shell session and run migrations:

`$ docker-compose run web rails db:create db:migrate db:test:prepare`

You can also run the tests with:

`$ docker-compose run web bundle exec rspec`

### Developing

Local change of the source code should take effect on web app running inside container. To restart the app simply click `Ctrl-C` and rerun `docker-compose up`. This will restart all containers including postgresql. To restart web app only:

`docker-compose restart web`
