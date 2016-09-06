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
* 21.07.2016: Erweiterung um ```sq_image_responsive_tag```
* 17.08.2016: Erweiterung um Helper für Darstellung von Kreditkarten Elementen und die entsprechenden Assets. Die Installation von ```bower install --save jquery-creditcardvalidator``` ist zwingend notwendig.
* 17.08.2016: Auslagerung von Assets

## Version 0.1.0

* 18.08.2016: Integration von blockUI und Formular Validierung. Für die Installation ist ```gem 'turbolinks', '~> 5.0.0'``` notwendig.
* 18.08.2016: Auslagern von gems in squibble_admin Gemfile
* 18.08.2016: Auslagerung der Squibble Generatoren
* 20.08.2016: Auslagerung des Meta Tags Handlings in ```MetaTagHandler```. Zur Verwendung ```include MetaTagsHandler``` im ApplicationController
* 22.08.2016: Erweiterung des ```index_collection_cache_key_with_pagination``` um :resource_class und :collection
* 23.08.2016: Erweiterung um ```:sq_search_keywords``` für SearchableModel, ```:thumbnail_show``` im SquibbleAdmin::Admin::Markup::ShowHelper
* 28.08.2016: Hinzufügen ```google_map_for_coordinates``` für SquibbleAdmin::Markup::GoogleHelper
* 29.08.2016: Integration ```Deletion::CreateOperation``` in SearchabelModel Concern (Callback)
* 30.08.2016: FIX: Navigation wurde im prod. Einsatz teilweise ausgeblendet. Überarbeitung Indizierung von Datensätzen
* 31.08.2016: FIX: Exceptions für CSVService bei einem Fehler in der CSVEntryOperation, leerer Collection oder falschen Typen innerhalb einer gegebenen Collection
* 06.09.2016: Optimierung ElasticSearch Indizierung

## Version 0.2.0

* 06.09.2016: Auslagerung der Konfiguration für Sidekiq. Erweiterung der bestehenden Konfiguration um zusätzliche komplett unabhängigen Pool für :low Priority Operationen.
* 06.09.2016: Auslagerung des OperationsService
* 06.09.2016: Auslagerung der Scripte für das Management der Applikationen (Unicorn, Sidekiq)
