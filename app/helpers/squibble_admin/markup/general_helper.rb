module SquibbleAdmin::Markup::GeneralHelper

  def async_background_processing(show, resource)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing',
           locals: {show: show, resource: resource}
  end

  def async_background_processing_icon(state)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing_icon',
           locals: {state: state}
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
end
