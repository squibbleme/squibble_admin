module SquibbleAdmin::Markup::GeneralHelper
  # Diese Methode retourniert einen Adresstag
  # für die übergebene Adresse.
  #
  # === Attribute
  # *+address+
  #
  def address_tag(address, options = {})
    render partial: 'helpers/squibble_admin/markup/general_helper/address_tag',
           locals: { resource: address, options: options }
  end

  def async_background_processing(show, resource)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing',
           locals: {show: show, resource: resource}
  end

  def async_background_processing_icon(state)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing_icon',
           locals: {state: state}
  end

  def sq_image_responsive_tag(source, title = nil, options = {})
    image_tag(source, class: [ 'img-responsive', options[:class] ], alt: title)
  end

  # Diese Methode retourniert die Standard ID
  # für eine Objekt. Dieser Helper soll auf Übersichts-Seiten
  # verwendet werden, damit eine konsistente ID für die entsprechenden
  # Attribute generiert werden kann.
  #
  # === Attribute
  # *+resource+
  #
  # === Beispiel
  # %tr{ default_overview_resource_attributes( resource ), data: { other: true } }
  #
  def default_overview_resource_attributes(resource)
    { id: "sq_collection:#{resource.id}" }
  end

  # Diese Methode kümmert sich um die einheitliche Ausgabe der Timestamps
  # für die Detailseiten von Datensätzen.
  def show_timestamps(show, resourze = resource)
    render partial: 'helpers/squibble_admin/markup/general_helper/show_timestamps',
           locals: { resource: resource, show: show }
  end
end
