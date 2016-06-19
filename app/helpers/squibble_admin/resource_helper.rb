module SquibbleAdmin::ResourceHelper

  def default_resource_actions(resource, &block)
    render partial: 'helpers/squibble_admin/markup/resource_helper/default_resource_actions',
           locals: { resource: resource, block: block }
  end

  # Diese Methode kümmert sich darum, dass für ein
  # übergebenes Attribute die entsprechende Übersetzung verwendet wird.
  # Standardmässig wird dabei die aktuelle :resource_class als Klasse für
  # die Übersetzung verwendet. Wird mit dem optionalen Parameter :resource_clazz
  # eine andere Klasse übergeben, so wird die Übersetzung anhand dieser Klasse
  # gemacht.
  #
  # === Optionen
  # *+resource_clazz+ - Alternative Klasse für das auslesen der Übersetzung
  #
  def resource_attribute_name(attribute, resource_clazz = resource_class, options = {})
    resource_clazz.human_attribute_name(attribute, options)
  end

  def translated_resource_class(resource_clazz = resource_class, count = 1)
    Rails.cache.fetch [ 'application_helper/translated_resource_class', resource_clazz.to_s, count ] do
      resource_clazz.model_name.human(count: count)
    end
  end
end
