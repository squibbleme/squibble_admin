module SquibbleAdmin::Markup::GoogleHelper
  def google_map_for_address(address, options = {})
    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_address',
           locals: { resource: address, options: options }
  end

  def google_map_for_coordinates(latitude, longitude, options = {})
    options[:draggable] = (options[:draggable].present? ? options[:draggable] : :true)
    options[:scrollwheel] = (options[:scrollwheel].present? ? options[:scrollwheel] : :false)

    locals = { latitude: latitude, longitude: longitude }.merge(options)

    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_coordinates',
           locals: locals
  end
end
