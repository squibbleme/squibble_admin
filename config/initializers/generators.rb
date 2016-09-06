Rails.application.config.generators do |g|
  g.javascripts false
  g.stylesheets false
  g.stylesheet_engine :less
  g.helper false
  g.template_engine :haml
end
