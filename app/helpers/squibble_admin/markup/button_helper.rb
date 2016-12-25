module SquibbleAdmin::Markup::ButtonHelper

  def clone_button(resource, size = :default, path = new_resource_path(clone_by_id: resource.id), options = {})
    action = options[:action].present? ? options[:action] = :create
    # return unless can? :create, resource
    render partial: 'helpers/squibble_admin/markup/button_helper/clone_button',
           locals: {path: path, size: size, enabled: can?(action, resource)}
  end

  def destroy_button(resource, size = :default, path = resource_path(resource.id), options = {})
    action = options[:action].present? ? options[:action] = :destroy
    render partial: 'helpers/squibble_admin/markup/button_helper/destroy_button',
           locals: {path: path, size: size, enabled: can?(action, resource)}
  end

  def edit_button(resource, size = :default, path = edit_resource_path(resource.id), options = {})
    action = options[:action].present? ? options[:action] = :update
    render partial: 'helpers/squibble_admin/markup/button_helper/edit_button',
           locals: {path: path, size: size, enabled: can?(action, resource)}
  end

  def show_button(resource, size = :default, path = resource_path(resource.id), options = {})
    action = options[:action].present? ? options[:action] = :show
    render partial: 'helpers/squibble_admin/markup/button_helper/show_button',
           locals: {path: path, size: size, enabled: can?(action, resource)}
  end

end
