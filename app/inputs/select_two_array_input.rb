class SelectTwoArrayInput < SimpleForm::Inputs::StringInput
  def input_html_options
    custom_options = { style: 'width: 100%;', multiple: true }

    value = object.send(attribute_name)
    custom_options[:value] = value.is_a?(Array) ? value.join(',') : value

    super.merge(custom_options)
  end
end
