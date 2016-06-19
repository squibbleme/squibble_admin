class FileImageInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    path = input_html_options.delete(:path)
    if path.present?
      image_path = path
    else
      version = input_html_options.delete(:preview_version) || :two_one
      use_default_url = options.delete(:use_default_url) || false

      image_path = begin
                     object.send(attribute_name).url(version)
                   rescue
                     ArgumentError
                   end
    end

    out = ''
    if object.send("#{attribute_name}?") || use_default_url
      out << template.image_tag(image_path, class: 'img-responsive')
    end
    "#{super}#{out}".html_safe
  end

  def input_html_options
    super[:class].delete('form-control')
    super[:accept] = 'image/*'
    super[:required] = object.send(attribute_name.to_s).nil?
    super
  end
end
