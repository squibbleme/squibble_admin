module SquibbleAdmin::Markup::GoogleHelper
  def google_map_for_address(address, options = {})
    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_address',
           locals: { resource: address, options: options }
  end

  # = google_map_for_coordinates resource.longitude, resource.latitude, height: resource.height, zoom: resource.zoom, marker_label: resource.marker_label, marker_content: resource.marker_content, draggable: :false, disableDefaultUI: :true
  #
  # === Attribute
  # *+latitude+ - Längengrad
  # *+longitude+ - Breitengrad
  #
  # === Optionen
  # *+scrollwheel+ -
  # *+draggable+ -
  # *+scaleControl+ -
  # *+navigationControl+ -
  # *+streetViewControl+ -
  # *+disableDefaultUI+ -
  #
  def google_map_for_coordinates(latitude, longitude, options = {})
    options[:latitude] = latitude
    options[:longitude] = longitude
    options[:draggable] = (options[:draggable].present? ? options[:draggable] : :true)
    options[:scrollwheel] = (options[:scrollwheel].present? ? options[:scrollwheel] : :false)

    options[:scaleControl] = (options[:scaleControl].present? ? options[:scaleControl] : :false)
    options[:navigationControl] = (options[:navigationControl].present? ? options[:navigationControl] : :false)
    options[:streetViewControl] = (options[:streetViewControl].present? ? options[:streetViewControl] : :false)
    options[:disableDefaultUI] = (options[:disableDefaultUI].present? ? options[:disableDefaultUI] : :false)

    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_coordinates',
           locals: {
            latitude: latitude, longitude: longitude,
             data_options: options
           }
  end
end
