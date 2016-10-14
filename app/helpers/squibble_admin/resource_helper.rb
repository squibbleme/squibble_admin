module SquibbleAdmin::ResourceHelper

  def default_resource_actions(resource, &block)
    render partial: 'helpers/squibble_admin/markup/resource_helper/default_resource_actions',
           locals: { resource: resource, block: block }
  end
end
