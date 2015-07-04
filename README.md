# Awesome GitHub Feed

## for development

### Setup

    $ cp settings.example.yml settings.yml

Modify settings.yml

### Clockworkd

Create an awesome GitHub feed

    # Start
    $ bundle exec clockworkd -c lib/clockwork.rb --log start

    # Stop
    $ bundle exec clockworkd -c lib/clockwork.rb --log stop

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

## Automatically `$ bundle update`

A pull request regularly creates by a trigger https://dashboard.heroku.com/apps/bu-awesome-github-feed
