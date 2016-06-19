module SquibbleAdmin::Markup::GeneralHelper
  # Diese Methode retourniert einen Adresstag
  # für die übergebene Adresse.
  #
  # === Attribute
  # *+address+
  #
  def address_tag(address, options = {})
    render partial: 'helpers/squibble_admin/markup/general_helper/address_tag',
           locals: { resource: address, options: options }
  end
end
