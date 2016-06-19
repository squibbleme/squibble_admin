class DateTimePickerInput < SimpleForm::Inputs::DateTimeInput
  def input(_wrapper_options)
    input_html_options[:type] = :datetime
    template.content_tag(:div) do
      options = input_html_options.merge(datepicker_options(object.send(attribute_name)))
      template.concat @builder.text_field(attribute_name, options)
    end
  end

  def datepicker_options(value = nil)
    { value: value.nil? ? nil : value.strftime('%Y-%m-%d %H:%M:00') }
  end

  def input_html_options
    custom_options = super

    # custom_options[:readonly] = true
    custom_options[:class] << 'form-control'

    custom_options
  end
end
