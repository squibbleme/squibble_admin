module SquibbleAdmin::Admin::Markup::ShowHelper

  def preview_show(resource, show_for, preview_path = nil)
    preview_path = resource.preview.thumb.url if preview_path.nil?
    render partial: 'squibble_admin/admin/markup/show_helper/preview_show',
           locals: { resource: resource, show: show_for, preview_path: preview_path }
  end

  def file_show(resource, show_for, preview_path = nil)
    preview_path = resource.file.thumb.url if preview_path.nil?
    render partial: 'squibble_admin/admin/markup/show_helper/file_show',
           locals: { resource: resource, show: show_for, preview_path: preview_path }
  end

  def image_show(resource, show_for, preview_path = nil)
    preview_path = resource.image.thumb.url if preview_path.nil?
    render partial: 'squibble_admin/admin/markup/show_helper/image_show',
           locals: { resource: resource, show: show_for, preview_path: preview_path }
  end
end
