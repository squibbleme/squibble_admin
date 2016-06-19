class PriceInput < SimpleForm::Inputs::StringInput
  include ActionView::Helpers::NumberHelper

  def input_html_options
    custom_options = super
    custom_options[:class] << 'form-control'
    custom_options[:class] << 'input-mask'
    custom_options[:class] << 'price'
    custom_options
  end

  def input(_wrapper_options)
    @builder.text_field(attribute_name, input_html_options.merge(price_options(object.send(attribute_name))))
  end

  def price_options(value = nil)
    { value: value.nil? ? nil : number_with_precision(value, precision: 2) }
  end
end
