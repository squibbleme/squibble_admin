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

### Controller Concerns

#### Squibble::LandingPageAttributes

```ruby
  include Squibble::LandingPageAttributes

  def package_params
    params.require(:resource)
          .permit(
            [...]
            squibble_landing_page_permitted_params
            [...]
          )
  end
```

#### Squibble::MetaKeywordAttributes

```ruby
  include Squibble::MetaKeywordAttributes

  def package_params
    params.require(:resource)
          .permit(
            [...]
            squibble_meta_keywords_permitted_params
            [...]
          )
  end
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
* 20.06.2016: Auslagerung der :permitted_params für :landing_page und :meta_keywords in Controller Concern
