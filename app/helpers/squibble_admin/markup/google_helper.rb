module SquibbleAdmin::Markup::GoogleHelper
  def google_map_for_address(address, options = {})
    render partial: 'helpers/squibble_admin/markup/google_helper/google_map_for_address',
           locals: { resource: address, options: options }
  end
end
