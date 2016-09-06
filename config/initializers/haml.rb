Haml::Template.options[:format] = :html5
Haml::Template.options[:remove_whitespace] = false
Haml::Template.options[:ugly] = Rails.env.production?
