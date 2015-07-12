# Awesome GitHub Feed

Deliver awesome GitHub feed

## for development

### Setup

    $ cp settings.example.yml settings.yml

Modify settings.yml

### Clockworkd

Create an awesome GitHub feed

    # Start
    $ bundle exec clockworkd -c clockwork.rb --log start

    # Stop
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
