# Awesome GitHub Feed

## Start daemon which creates an awesome GitHub feed

    $ bundle exec clockworkd -c clock.rb start --log

## Sinatra

    $ bundle exec ruby app.rb -e production

You can access http://localhost:4567/masutaka.private.atom?token=hogehoge in the case of the following `settings.yml`.

```yaml
feed_url:
  https://github.com/masutaka.private.atom?token=hogehoge
exclusion_keyword:
  jogai
path_to_output:
  /path/to/output/masutaka.private.atom
element_name:
  entry
fetch_interval_seconds:
  <%= 20.minutes %>
```
