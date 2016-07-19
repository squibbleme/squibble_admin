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

### Model Concerns

#### Squibble::Mongoid::Tree::TouchParent

  Soll ein Model bei :touch und :save auf den :parent-Objekten ebenfalls ein :touch auslösen, so muss nur im Model selbst folgender include eingetragen werden:

```ruby
  include Squibble::Mongoid::Tree::TouchParent
```

### Helper

```ruby
module ApplicationHelper
  [ ... ]
  include SquibbleAdmin
  [ ... ]
end
```

#### Dashboard Custom

```haml
  = show_dashboard_custom do
    = show_dashboard_custom_link print_business_invoice_path(resource.id), icon: 'fa fa-print', label: route_translation(:'dashboard.print_with_esr')

  = show_dashboard_custom do
    = show_dashboard_custom_link admin_business_period_generate_csv_analysis_path(period_id: resource.id), method: :post, icon: 'fa fa-line-chart', label: resource_attribute_name(:generate_csv_analysis)
```

## Changelog

* 19.06.2016: Init
* 20.06.2016: Auslagerung der :permitted_params für :landing_page und :meta_keywords in Controller Concern
* 20.06.2016: Helper für DashboardCustom
* 22.06.2016: Auslagern der admin/errors Templates
* 23.06.2016: Auslagerung der Standard Assets (admin und general)
* 23.06.2016: Auslagerung des Helpers für Flash Messages
* 29.06.2016: Squibble::Mongoid::Tree::TouchParent Concern, welcher bei :save und :touch einen :touch auf den :parent Objekten ausführt
* 01.07.2016: Indizierung der Application Log Einträge in ElasticSearch
* 14.07.2016: Auslagerung der SearchableModel und SearchableController aus Squibble in SquibbleAdmin
* 14.07.2016: Auslagerung der Squibble::LandingPage, Squibble::MetaAttributes und Squibble::BackgroundProcessing Concerns
* 14.07.2016: Auslagerung der layouts/shared/admin und layouts/shared/mailer inkl. mailer Layout
* 19.07.2016: Erweiterung um ```save_resource(resource, options = {})``` im Squibble Service für standartisiertes Speichern inkl. Logging von Datensätzen.
