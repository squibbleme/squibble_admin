module SquibbleAdmin::Markup::GeneralHelper

  def async_background_processing(show, resource)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing',
           locals: {show: show, resource: resource}
  end

  def async_background_processing_icon(state)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing_icon',
           locals: {state: state}
  end
end
