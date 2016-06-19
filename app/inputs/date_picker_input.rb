class DatePickerInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    # input_html_options[:readonly] = true
    input_html_options[:class] << 'form-control'
    @builder.text_field(attribute_name, input_html_options)
  end
end
