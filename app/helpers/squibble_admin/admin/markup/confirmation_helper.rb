# Helper für die Darstellung von Bestätigungsseiten
# im Admin Bereich.
#
module SquibbleAdmin::Admin::Markup::ConfirmationHelper

  def confirmation_note(path, options = {})
    options[:data] = {}

    options[:data][:method] = :post if options[:data][:method].nil?
    options[:translation_key] = params[:action].to_sym if options[:translation_key].nil?

    options[:cancel_path] = resource_path if options[:cancel_path].nil?

    render partial: 'helpers/squibble_admin/admin/markup/confirmation_helper/confirmation_note',
           locals: {
             path: path,
             options: options
           }
  end
end
