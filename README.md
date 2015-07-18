# Awesome GitHub Feed [![circleci badge][circleci-badge]][circleci-link]

Deliver awesome GitHub feed

## for development

### Setup

    $ cp config/settings.example.yml config/settings.yml

Modify config/settings.yml

### Clockwork

Create an awesome GitHub feed

    # Start
    $ bundle exec clockwork clockwork.rb

    # Start daemon
    $ export NRCONFIG=`pwd`/config/newrelic.yml
    $ bundle exec clockworkd -c clockwork.rb --log start

    # Stop daemon
    $ bundle exec clockworkd -c clockwork.rb --log stop

### Sinatra

    $ bundle exec ruby app.rb

You can access http://localhost:4567/masutaka.private.atom?token=xxxxx in the case of the following `settings.yml`.

```yaml
github:
  account:
    masutaka
  feed_token:
    xxxxx
exclusion_keyword:
  keyword
element_name:
  entry
fetch_interval_seconds:
  <%= 10.minutes %>
output_dir:
  /path/to/output
```

## Automatic deployment

When any commits are pushed to master, [CircleCI will deploy to masutaka.net](https://circleci.com/gh/masutaka/awesome-github-feed/tree/master).

## Automatic `$ bundle update`

A pull request regularly creates by a trigger https://dashboard.heroku.com/apps/bu-awesome-github-feed

[circleci-badge]: https://circleci.com/gh/masutaka/awesome-github-feed/tree/master.svg?style=svg
[circleci-link]: https://circleci.com/gh/masutaka/awesome-github-feed/tree/master
