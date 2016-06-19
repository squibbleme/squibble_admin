module SquibbleAdmin::Markup::PortletHelper
  def portlet(options = {}, &block)
    content_tag(:div, class: ['portlet light bordered', options[:class]], &block)
  end

  def portlet_title(options = {}, &block)
    content_tag(:div, class: ['portlet-title', options[:class]], &block)
  end

  # Portlet Standard-Titel im Show-Template
  #
  def portlet_title_default_show_caption(subtitle = nil)
    portlet_title_caption(resource, subtitle)
  end

  # Portlet Titel im Show-Template (:content als Titel)
  #
  def portlet_title_caption(content, subtitle = nil)
    content_tag(:div, nil, class: 'caption') do
      tmp = content_tag(:span, content, class: 'caption-subject')
      tmp << content_tag(:span, subtitle, class: 'caption-helper')
    end
  end

  def portlet_body(options = {}, &block)
    content_tag(:div, class: ['portlet-body', options[:class]], id: options[:id], &block)
  end

  def portlet_body_form(options = {}, &block)
    content_tag(:div, class: ['portlet-body form', options[:class]], id: options[:id], &block)
  end

  # Diese Methode retourniert den Standard Portlet Titel für
  # allgemeine Informationen für die Formulare
  # im Admin Bereich.
  #
  def portlet_title_form_general_information(content = t('helpers.general_information'), subtitle = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::PortletHelper.portlet_title_form_general_information', content, subtitle] do
      portlet_title(class: 'portlet-title-form-general-information') do
        portlet_title_caption(content, subtitle)
      end
    end
  end

  def portlet_body_form_additional_information(&block)
    content_tag(:div, class: ['portlet-body portlet-body-form-additional-information form display-hide'], &block)
  end

  # Diese Methode retourniert den Standard Portlet Titel für zusätzliche
  # Informationen.
  #
  def portlet_title_form_additional_information(content = resource_attribute_name(:additional_information), subtitle = nil)
    Rails.cache.fetch ['SquibbleAdmin::Markup::PortletHelper.portlet_title_form_additional_information', content, subtitle] do
      content_tag(:div, nil, class: 'portlet-title portlet-title-form-additional-information') do
        tmp = portlet_title_caption(content, subtitle)

        tmp << content_tag(:div, nil, class: 'tools') do
          content_tag(:a, nil, class: 'expand', href: 'javascript:;')
        end
      end
    end
  end

  # Diese Methode retourniert das Standard Portlet für die Darstellung
  # der :internal_description im "Additional Field" Stil.
  #
  def portlet_form_additional_field_internal_description(f, options = {})
    portlet do
      tmp = portlet_title_form_additional_information(resource_attribute_name(:internal_description))
      tmp << portlet_body_form_additional_information do
        form_field_internal_description(f, rows: (options[:rows].present? ? options[:rows] : 10), wrapper: :no_label)
      end
    end
  end

  def portlet_form_additional_field_landing_page(form)
    render partial: 'helpers/squibble_admin/markup/portlet_helper/portlet_form_additional_field_landing_page',
           locals: { f: form }
  end
end
