# Squibble Admin

```ruby
  gem 'squibble_admin', git: 'git://github.com/squibbleme/squibble_admin.git'
```

## Integration

### Gemfile

```ruby
[...]
  gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
  gem 'slack-notifier'
[...]
```

### Helper

```ruby
module ApplicationHelper
  [ ... ]
  include SquibbleAdmin
  [ ... ]
end
```

## Changelog

* 19.06.2016: Init
