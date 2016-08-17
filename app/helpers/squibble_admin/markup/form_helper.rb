module SquibbleAdmin::Markup::FormHelper
  def form_field_ckeditor(principal, form, key, options = {})
    base_options = { class: 'ckeditor' }

    if !principal.nil? && principal.main_domain_connected.present?
      base_options['data-ckeditor-base-href'] = principal.main_domain_connected.squibble_alias.find_by(key: :production).uri
      base_options['data-ckeditor-assets-name'] = '/assets/application-custom.css,/assets/application-squibble.css,/assets/application-vendor.css'
    end

    options.each do |key, value|
      base_options["data-ckeditor-#{key}"] = value
    end

    base_options

    form.input key,
               as: :text,
               input_html: base_options,
               wrapper: options[:wrapper]
  end

  def form_field_internal_description(form, options = {})
    options[:rows] = 5 if options[:rows].nil?
    form.input :internal_description, as: :text,
                                      input_html: {
                                        rows: options[:rows]
                                      },
                                      hint: resource_attribute_name(:internal_description_hint),
                                      wrapper: options[:wrapper]
  end

  def form_field_meta_attributes(form)
    render partial: 'helpers/squibble_admin/markup/form_helper/form_field_meta_attributes',
           locals: { f: form }
  end

  def form_field_meta_description(form)
    form.input :meta_description,
               as: :text,
               input_html: {
                 rows: 5
               }
  end

  def form_field_meta_keywords(form)
    form.input :meta_keywords, as: :select_two_array
  end

  #
  # === Attribute
  # *+form+
  # *+attribute+
  #
  # === Optionen
  # *+positive+ - Durch die Übergabe von true/false, kann gesteuert werden,
  # ob es sich nur um positive Zahlen handeln soll.
  # Standardwert: true
  # *+options+ - Hash mit Optionen
  #   => *+positive+ - Durch die Übergabe von true/false, kann gesteuert werden,
  #      ob es sich nur um positive Zahlen handeln soll.
  #      Standardwert: true
  #   => *+data.unit+ - Über das Attribut :unit kann die Einheit für dieses Feld
  #      definiert werden. Diese Einheit wird als Group Addon für das Element
  #      dargestellt.
  #      Beispiel: form_field_number(f, :milage_start, { data: { unit: 'km' } } )
  #
  def form_field_number(form, attribute, options = {})
    options[:positive] = true if options[:positive].nil?

    form.input attribute,
               as: :decimal,
               input_html: {
                 min: (options[:positive] == true ? 0 : nil),
                 max: (options[:max].present? ? options[:max] : nil),
                 data: options[:data],
                 class: :number
               },
               disabled: (options[:disabled] == true ? true : false),
               autofocus: options[:autofocus],
               hint: options[:hint]
  end

  def form_field_percentage(form, attribute = :percentage, options = {})
    form.input attribute,
               as: :decimal,
               input_html: {
                 min: 0,
                 max: 100,
                 class: :percentage
               },
               disabled: (options[:disabled] == true ? true : false),
               autofocus: options[:autofocus],
               hint: options[:hint]
  end

  # Diese Methode retourniert das Formularfeld für einen Preis.
  # Dabei wird das verschachtelte Formularelement generiert, welches
  # für das Attribut :attribute generiert wird.
  #
  def form_field_price(form, attribute = :price, resource_clazz = resource_class, options = {})
    render partial: 'helpers/squibble_admin/markup/form_helper/form_field_price',
           locals: { attribute: attribute, f: form, options: options, resource_class: resource_clazz }
  end

  def form_file_upload(form, attribute, options = {})
    render partial: 'helpers/squibble_admin/markup/form_helper/form_file_upload',
           locals: { attribute: attribute, f: form, options: options }
  end

  def form_error_messages(errors, options = {})
    return unless errors.present?
    render partial: 'helpers/squibble_admin/markup/form_helper/form_error_messages',
           locals: { errors: errors, options: options }
  end

  def form_credit_card_security_code(form, attribute, options = {})
    form.input attribute,
               input_html: { data: options[:data], class: :'sq-credit-card', min: 3, max: 4 },
               required: (options[:required] == true ? true : false),
               placeholder: (options[:placeholder].present? ? options[:placeholder] : nil),
               wrapper: (options[:wrapper].present? ? options[:wrapper] : nil),
               disabled: (options[:disabled] == true ? true : false),
               autofocus: options[:autofocus],
               hint: options[:hint]
  end

  def form_credit_card_number(form, attribute, options = {})
    content_tag(:div, nil, class: 'input-group sq-credit-card') do
      tmp = form.input attribute,
                       input_html: {
                         data: options[:data],
                         class: :'sq-credit-card'
                       },
                       required: (options[:required] == true ? true : false),
                       placeholder: (options[:placeholder].present? ? options[:placeholder] : nil),
                       wrapper: (options[:wrapper].present? ? options[:wrapper] : nil),
                       disabled: (options[:disabled] == true ? true : false),
                       autofocus: options[:autofocus],
                       hint: options[:hint]

      tmp << content_tag(:span, nil, class: 'input-group-addon') do
        content_tag(:i, nil, class: 'fa fa-cc')
      end
    end
  end
end
