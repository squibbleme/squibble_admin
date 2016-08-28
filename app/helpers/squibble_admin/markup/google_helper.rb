module SquibbleAdmin::Markup::GoogleHelper
  def google_map_for_address(address, options = {})
    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_address',
           locals: { resource: address, options: options }
  end

  def google_map_for_coordinates(latitude, longitude, options = {})
    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_coordinates',
           locals: { latitude: latitude, longitude: longitude, options: options }
  end
end
