module SquibbleAdmin::Markup::ShowHelper
  # Diese Methoden stellen die standartisierte Funktionalität für die Darstellung
  # von Einträgen in den :dashboard_custom zur Verfügung.
  #
  # === Anwendung
  #
  # = show_dashboard_custom do
  #   = show_dashboard_custom_link :path, icon: :icon, label: :label
  #
  def show_dashboard_custom(options = {}, &block)
    content_tag(:div, class: ['sq-action', options[:class]], id: options[:id], &block)
  end

  def show_dashboard_custom_link(link, options = {})
    content_tag(:a, nil, href: link, data: { method: ( options[:method] || nil ) }) do
      tmp = content_tag :div, nil, class: 'sq-action-title' do
        content_tag :i, nil, class: options[:icon]
      end

      tmp << content_tag(:div, nil, class: 'sq-action-text', data: { toggle: :tooltip, placement: :top }, title: options[:label]) do
        content_tag :span, options[:label]
      end
    end
  end

end
