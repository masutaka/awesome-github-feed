# [WIP] Awesome GitHub Feed

## Clockworkd

Create an awesome GitHub feed

    # Start
    $ bundle exec clockworkd -c clock.rb start --log

    # Stop
    $ kill `cat tmp/clockworkd.clock.pid`

## Sinatra

    $ bundle exec ruby app.rb -e production

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
  <%= 3.minutes %>
output_dir:
  /path/to/output
```
