module SquibbleAdmin::Mailer::Markup::GeneralHelper
  def sq_mail_header(title, principal = nil)
    unless sq_principal?(principal)
      render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_header',
             locals: { title: title }
    end
  end

  def sq_mail_header_full_width(principal = nil)
    if sq_principal?(principal)
      render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_header_custom_full_width'
    end
  end

  def sq_mail_header_image(principal = nil, options = {})
    if sq_principal?(principal)
      image_tag(sq_mail_asset_url('squibble_email_header.png'),
        width: 610, height: 250,
        class: 'header-image-custom',
        alt: 'Squibble Header Logo',
        title: 'Squibble Header Logo',
        align: :left,
        style: 'float: left; display: block; vertical-align: bottom; margin: 0;',
      )
    else
      styles = if options[:style].present?
                 options[:style]
               end

      brand_name = principal.present? ? principal.name : Settings.site.name

      image_tag("#{sq_mail_header_image_url(principal)}",
        width: sq_mail_header_image_width(principal),
        alt: "#{brand_name} Logo Header",
        title: "#{brand_name} Logo Header",
        style: "#{styles}",
        align: :right
        # height: sq_mail_header_image_height(principal),
      )
    end
  end

  def sq_mail_header_image_height(principal = nil)
    if !principal.nil? && !principal.module_setting_mailer.nil? && !principal.module_setting_mailer.header_dimensions.nil?
      dimensions = principal.module_setting_mailer.header_dimensions[:original]
    end

    (dimensions.nil? || !use_principal_layout?) ? Settings.layout.mailer.foundation_mailer.images.header_image.height : dimensions[:height]
  end

  def sq_mail_header_image_width(principal = nil)
    if !principal.nil? && !principal.module_setting_mailer.nil? && !principal.module_setting_mailer.header_dimensions.nil?
      dimensions = principal.module_setting_mailer.header_dimensions[:original]
    end

    width = (dimensions.nil? || !use_principal_layout?) ? Settings.layout.mailer.foundation_mailer.images.header_image.width : dimensions[:width]
    width > 300 ? 300 : width
  end

  def sq_mail_footer(principal = nil)
    if sq_principal?(principal)
      render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_footer_custom'
    else
      render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_footer'
    end
  end

  def sq_mail_footer_image(principal = nil, options = {})
    styles = if options[:style].present?
               options[:style]
             end

    brand_name = principal.present? ? principal.name : Settings.site.name

    if !principal.nil? && !principal.module_setting_mailer.nil? && !principal.module_setting_mailer.footer_dimensions.nil?
      dimensions = principal.module_setting_mailer.footer_dimensions[:original]
    end

    image_tag("#{sq_mail_footer_image_url(principal)}",
      width: sq_mail_footer_image_width(principal),
      alt: "#{brand_name} Logo Footer",
      title: "#{brand_name} Logo Footer",
      style: "#{styles}",
      align: :center
      # height: "#{(dimensions.nil? || !use_principal_layout?) ? Settings.layout.mailer.foundation_mailer.images.footer_image.height : dimensions[:height]}",
    )
  end

  def sq_mail_footer_image_width(principal = nil)
    if !principal.nil? && !principal.module_setting_mailer.nil? && !principal.module_setting_mailer.footer_dimensions.nil?
      dimensions = principal.module_setting_mailer.footer_dimensions[:original]
    end

    width = (dimensions.nil? || !use_principal_layout?) ? Settings.layout.mailer.foundation_mailer.images.footer_image.width : dimensions[:width]
    width > 300 ? 300 : width
  end


  def sq_mail_button(text, href, principal = nil, options = {})
    if sq_principal?(principal)
      height = options[:height].present? ? options[:height] : 15
      font_size = options[:font_size].present? ? options[:font_size] : 11

      border_color = options[:border_color].present? ? options[:border_color] : '#000000'
      text_color = options[:text_color].present? ? options[:text_color] : '#ffffff'

      text = text.upcase
    else
      height = options[:height].present? ? options[:height] : 30
      font_size = options[:font_size].present? ? options[:font_size] : 20

      border_color = options[:border_color].present? ? options[:border_color] : sq_mail_color(:border, @principal)
      text_color = options[:text_color].present? ? options[:text_color] : sq_mail_color(:container_bg, @principal)
    end
      width = options[:width].present? ? options[:width] : 290
      margin = options[:margin].present? ? options[:margin] : 15
      button_color = options[:button_color].present? ? options[:button_color] : sq_mail_color(:primary, @principal)

    render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_button',
           locals: {
             text: text,
             href: href,
             width: width,
             height: height,
             margin: margin,
             font_size: font_size,
             button_color: button_color,
             border_color: border_color,
             text_color: text_color
           }
  end


  def sq_mail_p(options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    color = if options[:color].present?
              sq_mail_color(options[:color], @principal)
            else
              sq_mail_color(:text, @principal)
            end
    content_tag(:p, style: "color: #{color}; font-size: 14px; margin-top: 10px; margin-bottom: 10px; #{styles}", &block)
  end

  def sq_mail_a(href, options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    content_tag(:a, href: href, style: "outline: none; text-decoration: none; color: #{sq_mail_color(:link, @principal)}; #{styles}", &block)
  end

  def sq_mail_mail_to(address, options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    content_tag(:a, href: "mailto:#{address}", style: "outline: none; text-decoration: none; color: #{sq_mail_color(:link, @principal)}; #{styles}", &block)
  end

  def sq_mail_h1(options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    color = if options[:color].present?
              sq_mail_color(options[:color], @principal)
            else
              sq_mail_color(:text, @principal)
            end

    content_tag(:h1,
                style: "color: #{color}; font-size: 20px; text-align: left; margin-top: 15px; margin-bottom: 30px; #{styles}",
                &block)
  end

  def sq_mail_h2(options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    color = if options[:color].present?
              sq_mail_color(options[:color], @principal)
            else
              sq_mail_color(:text, @principal)
            end

    content_tag(:h2,
                style: "color: #{color}; font-size: 18px; text-align: left; margin-top: 10px; margin-bottom: 20px; #{styles}",
                &block)
  end

  def sq_mail_table_container(&block)
    content_tag(:table,
                class: 'container content-table',
                style: 'width: 550px; margin: 0 auto; padding: 0 !important; text-align: center; border-spacing: 0; border-collapse: collapse;',
                &block)
  end

  def sq_mail_table_tr(&block)
    content_tag(:table) do
      content_tag(:tr, &block)
    end
  end

  def sq_mail_td_panel(options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    classes = if options[:class].present?
                options[:class]
              end

    content_tag(:tr, style: 'padding: 0;', class: "#{classes}") do
      content_tag(:td,
                class: "panel #{classes}",
                style: "background: #{sq_mail_color(:well_bg, @principal)}; max-width: 528px; border: 1px solid #{sq_mail_color(:border, @principal)}; padding: 10px 10px 10px 10px; margin-bottom: 10px; #{styles}",
                &block)
    end
  end

  def sq_mail_table(amount, options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    classes = if options[:class].present?
                options[:class]
              end

    if [:one, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :eleven, :twelve].include? amount.to_sym
      render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_table',
             locals: {
               classes: classes,
               amount: amount,
               block: block,
               styles: styles,
               width: eval('Settings.layout.mailer.foundation_mailer.width.' + amount.to_s)
             }
    end
  end

  def sq_mail_td_sub_columns(amount, options = {}, &block)
    styles = if options[:style].present?
               options[:style]
             end
    classes = if options[:class].present?
                options[:class]
              end

    if [:one, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :eleven, :twelve].include? amount.to_sym
      render partial: 'helpers/squibble_admin/mailer/markup/general_helper/sq_mail_td_sub_columns',
             locals: {
               amount: amount,
               block: block,
               styles: "padding: 0; #{styles}",
               classes: classes,
               width: eval('Settings.layout.mailer.foundation_mailer.width.' + amount.to_s)
             }
    end
  end

  # # TODO: Auslagern in Template sq_mail_table_columns(:width, options = {}, &block)
  # #
  # def sq_mail_table_twelve_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'twelve columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.twelve}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.twelve}px; #{styles}", &block)
  # end

  # def sq_mail_table_eleven_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'eleven columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.eleven}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.eleven}px; #{styles}", &block)
  # end

  # def sq_mail_table_ten_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'ten columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.ten}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.ten}px; #{styles}", &block)
  # end

  # def sq_mail_table_nine_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'nine columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.nine}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.nine}px; #{styles}", &block)
  # end

  # def sq_mail_table_eight_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'eight columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.eight}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.eight}px; #{styles}", &block)
  # end

  # def sq_mail_table_seven_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'seven columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.seven}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.seven}px; #{styles}", &block)
  # end

  # def sq_mail_table_six_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'six columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.six}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.six}px; #{styles}", &block)
  # end

  # def sq_mail_table_five_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'five columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.five}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.five}px; #{styles}", &block)
  # end

  # def sq_mail_table_four_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'four columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.four}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.four}px; #{styles}", &block)
  # end

  # def sq_mail_table_three_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'three columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.three}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.three}px; #{styles}", &block)
  # end

  # def sq_mail_table_two_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'two columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.two}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.two}px; #{styles}", &block)
  # end

  # def sq_mail_table_one_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   content_tag(:table, class: 'one columns', style: "min-width: #{Settings.layout.mailer.foundation_mailer.width_percentage.one}; margin: 0 auto; padding: 0; width: #{Settings.layout.mailer.foundation_mailer.width.one}px; #{styles}", &block)
  # end

  # def sq_mail_td_twelve_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "twelve sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.twelve}; #{styles}", &block)
  # end

  # def sq_mail_td_eleven_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "eleven sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.eleven}; #{styles}", &block)
  # end

  # def sq_mail_td_ten_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "ten sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.ten}; #{styles}", &block)
  # end

  # def sq_mail_td_nine_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "nine sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.nine}; #{styles}", &block)
  # end

  # def sq_mail_td_eight_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "eight sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.eight}; #{styles}", &block)
  # end

  # def sq_mail_td_seven_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "seven sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.seven}; #{styles}", &block)
  # end

  # def sq_mail_td_six_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "six sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.six}; #{styles}", &block)
  # end

  # def sq_mail_td_five_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "five sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.five}; #{styles}", &block)
  # end

  # def sq_mail_td_four_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "four sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.four}; #{styles}", &block)
  # end

  # def sq_mail_td_three_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "three sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.three}; #{styles}", &block)
  # end

  # def sq_mail_td_two_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "two sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.two}; #{styles}", &block)
  # end

  # def sq_mail_td_one_sub_columns(options = {}, &block)
  #   styles = if options[:style].present?
  #              options[:style]
  #            end
  #   classes = if options[:class].present?
  #               options[:class]
  #             end

  #   content_tag(:td, class: "one sub-columns #{classes}", style: "min-width: 0px; width: #{Settings.layout.mailer.foundation_mailer.width_percentage.one}; #{styles}", &block)
  # end
end
