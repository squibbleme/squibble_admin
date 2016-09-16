module SquibbleAdmin::Mailer::GeneralHelper
  
  def sq_mail_principal_url(principal = nil)
    if principal.nil? || !principal.main_domain_connected.present?
      Settings.site.url
    else
      principal.main_domain_connected
    end
  end

  def sq_mail_asset_url(asset)
    "http://#{Rails.application.routes.default_url_options[:host]}/assets/#{asset}"
  end

  def sq_mail_color_without_principal(key)
    Rails.cache.fetch ['Mailer::GeneralHelper.sq_mail_color', key] do
      case key
      when :primary
        Settings.layout.mailer.foundation_mailer.colors.sq_brand_primary
      when :secondary
        Settings.layout.mailer.foundation_mailer.colors.sq_brand_secondary
      when :link
        Settings.layout.mailer.foundation_mailer.colors.sq_brand_secondary
      when :text
        Settings.layout.mailer.foundation_mailer.colors.sq_text_color
      when :body_bg
        Settings.layout.mailer.foundation_mailer.colors.sq_body_bg
      when :container_bg
        Settings.layout.mailer.foundation_mailer.colors.sq_container_bg
      when :well_bg
        Settings.layout.mailer.foundation_mailer.colors.sq_well_bg
      when :border
        Settings.layout.mailer.foundation_mailer.colors.sq_border
      when :white
        Settings.layout.mailer.foundation_mailer.colors.sq_white
      when :black
        Settings.layout.mailer.foundation_mailer.colors.sq_black
      else
        key
      end
    end
  end

  def sq_mail_color_with_principal(key, principal)
    Rails.cache.fetch ['Mailer::GeneralHelper.sq_mail_color_with_principal', key, principal, use_principal_layout?] do
      if use_principal_layout?
        mailer_setting = if principal.module_setting_mailer.present?
                          principal.module_setting_mailer
                        else
                          principal.build_module_setting_mailer
                        end
      else
        mailer_setting = begin
                           Backend::Principal::ModuleSetting::MailerSetting.find_by(principal_id: Settings.default.application_principal_id)
                         rescue Mongoid::Errors::DocumentNotFound
                           raise ArgumentError, 'Unable to find MailerSetting for ApplicationPrincipal in Squibble.yml'
                         end
      end

      case key
      when :primary
        mailer_setting.color_brand_primary
      when :secondary
        mailer_setting.color_brand_secondary
      when :link
        mailer_setting.color_brand_secondary
      when :text
        mailer_setting.color_text
      when :body_bg
        mailer_setting.color_body_bg
      when :container_bg
        mailer_setting.color_container_bg
      when :well_bg
        mailer_setting.color_well_bg
      when :border
        mailer_setting.color_border
      when :white
        mailer_setting.color_white
      when :black
        mailer_setting.color_black
      else
        key
      end
    end
  end

  def sq_mail_color(key, principal = nil)
    if principal.nil?
      sq_mail_color_without_principal(key)

    else
      sq_mail_color_with_principal(key, principal)

    end
  end

  def sq_mail_footer_image_url(principal = nil)
    if principal.nil? || principal.module_setting_mailer.nil? || !use_principal_layout?
      sq_mail_asset_url(Settings.layout.mailer.foundation_mailer.images.footer_image.file_name)

    else
      mailer_setting = principal.module_setting_mailer

      if mailer_setting.footer_image.present?
        mailer_setting.footer_image.url
      else
        sq_mail_asset_url(Settings.layout.mailer.foundation_mailer.images.footer_image.file_name)
      end
    end
  end

  def sq_mail_header_image_url(principal = nil)
    if principal.nil? || principal.module_setting_mailer.nil? || !use_principal_layout?
      sq_mail_asset_url(Settings.layout.mailer.foundation_mailer.images.header_image.file_name)

    else
      mailer_setting = principal.module_setting_mailer

      if mailer_setting.header_image.present?
        mailer_setting.header_image.url
      else
        sq_mail_asset_url(Settings.layout.mailer.foundation_mailer.images.header_image.file_name)
      end
    end
  end

  def sq_mail_price(value, principal = nil)
    if principal.nil?
      number_to_currency(value, unit: Settings.company.currency.unit)
    else
      number_to_currency(value, unit: principal.currency.unit)
    end
  end

  # Diese Methode returniert, ob das mandantenspezifische Layout aus den
  # ModuleSetting::MailerSetting des Mandanten genutzt werden soll
  #
  def use_principal_layout?
    @enable_principal_layout == true
  end
end
