module SquibbleAdmin::Markup::GeneralHelper
  def google_map_for_address(address, options = {})
    render partial: 'helpers/global/markup/google_helper/google_map_for_address',
           locals: { resource: address, options: options }
  end
end
