module SquibbleAdmin::Markup::FlashMessagesHelper
  def flash_messages( options = {} )
    return unless notice.present? || alert.present?
    render partial: 'helpers/squibble_admin/markup/flassh_messages_helper/flash_messages',
           locals: { notice: notice, alert: alert, container: options[:container] }
  end
end
