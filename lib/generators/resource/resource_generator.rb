class ResourceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def defaults
    @internal_module_name = "#{name.deconstantize.underscore.gsub('_', '-')}/#{name.demodulize.underscore.pluralize}"
    @name = name
  end

  def generate_controllers
    puts 'Generieren der Controller ...'.light_blue
    @admin_controller = "Admin#{name.deconstantize.empty? ? nil : '::'}#{name.deconstantize}::#{name.demodulize.pluralize}Controller"
    admin_controller_path = "app/controllers/admin/#{@internal_module_name}_controller.rb"

    @collection_name = name.demodulize.underscore.pluralize
    @resource_name = name.demodulize.underscore

    template 'controller/admin_controller.rb.erb', admin_controller_path
  end

  def generate_views
    admin_view_path = "app/views/admin/#{@internal_module_name}"

    puts 'Generieren der benötigten Views ...'.light_blue

    # Generiere _show_general.html.haml
    template 'views/admin/_show_general.html.haml', "#{admin_view_path}/_show_general.html.haml"

    # Generiere _show_general.html.haml
    template 'views/admin/_form_general.html.haml', "#{admin_view_path}/_form_general.html.haml"

    # Generieren _table_head.html.haml
    template 'views/admin/_table_head.html.haml', "#{admin_view_path}/_table_head.html.haml"

    # Generieren _table_row.html.haml
    template 'views/admin/_table_row.html.haml', "#{admin_view_path}/_table_row.html.haml"
  end

  def generate_translations
    puts 'Generieren der benötigten Übersetzungsdateien ...'.light_blue

    # Ablage des Modulnamens: Foo::Bar::Baz => foo
    module_name = name.split('::').first.downcase

    # Prüfen, ob die Datei Model Übersetzungen existieren
    locales = [ :de ]
    module_translations = [ :models, :errors, :attributes ]

    locales.each do |locale|
      module_translations.each do |module_translation|
        file_name = "models/#{locale}.#{module_name}.#{module_translation}.yml"
        file_path = Rails.root.join('config', 'locales', file_name)
        unless File.exists? file_path
          puts "Datei #{file_path} existiert nicht und wird nun erstellt ..."

          template "config/locales/model.#{locale}.#{module_translation}.yml.erb", "config/locales/#{file_name}"
        end
      end
    end
  end
end
