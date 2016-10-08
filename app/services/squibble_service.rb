module SquibbleService
  require 'slack-notifier'

  ALLOWED_LOG_LEVELS = [:debug, :info, :error, :fatal].freeze

  private

  # Diese Methode kümmert sich darum, dass Log Mitteilungen korrekt und gleich formatiert
  # ausgegeben werden.
  #
  # === Attribute
  # *+level+ - Log Level. Zulässige Log Level sind in der :ALLOWED_LOG_LEVELS definiert.
  # *+message+ - Nachricht, die ins Log File ausgegeben werden soll.
  #
  # === Optionen
  # *+options+
  #
  def log(level, message, options = {})
    fail ArgumentError('Only allowed to pass a hash for :options') unless options.is_a?(Hash)

    # Abbruch für :debug in Produktiver Umgebung.
    #
    return if level == :debug && Rails.env.production?

    if ALLOWED_LOG_LEVELS.include?(level)

      # msg = if options.empty?
      #         "#{self.class}: #{message}"
      #       else
      #         options_array = []
      #         options.each do |key, value|
      #           options_array << "#{key}: #{value} {#{options_array.join(', ')}}"
      #         end

      #         "#{self.class}: #{message} {#{options_array.join(', ')}}"
      #       end

      entry = Elasticsearch::LogEntry.new(class_name: self.class.to_s, level: level, message: message, options: options)

      if options[:principal_id].present?
        begin
          principal = Backend::Principal.find(options[:principal_id])
        rescue Mongoid::Errors::DocumentNotFound
        else
          entry.options[:principal] = {
            id: principal.id,
            name: principal.name,
            to_param: principal.to_param
          }
        end
      end

      begin
        entry.save
      rescue Faraday::TimeoutError => e
        msg = "Faraday::TimeoutError: Unable to save '#{message}': #{e.message}"
        Rails.logger.application.error msg
      rescue SystemStackError => e
        msg = "SystemStackError: Unable to save '#{message}': #{e.message}"
        Rails.logger.application.error msg
      end

      return unless Rails.env.production?
      if [:error, :fatal].include?(level)
        Slack::PingWorker.perform_async(
          Rails.application.secrets['slack']['webhook_url'], "[#{level.upcase}]: #{message}",
          {username: 'Squibble'}
        )
      end
    else
      fail ArgumentError "Level :#{level} is an invalid log level"
    end
  end

  # Diese Methode retourniert die Übersetzungen für die aktuelle
  # Klasse abhängig vom entsprechenden Klassennamen.
  #
  # === Attribute
  # *+namespace+
  # *+key+ -
  #
  # === Optionen
  # *+options+
  #
  def class_translations(namespace, key, options = {})
    I18n.t("#{namespace}.#{self.class.to_s.underscore.tr('/', '.')}.#{key}", options)
  end

  # Diese Methode kümmert sich darum, dass für einen mitgegebenen
  # Dateipfad das Directory existiert oder rekursiv angelegt wird.
  #
  # Auf dem OpenStruct Objekt können :path, :basename und :directory
  # abgefragt werden.
  #
  # === Attribute
  # *+file_path+ Dateipfad (Pathname Objekt: Rails.root.join(x))
  #
  def create_directory_recursively_unless_exists_and_return(file_path)
    path_object = OpenStruct.new(
      path: file_path,
      basename: File.basename(file_path),
      directory: File.dirname(file_path)
    )

    # Generiert Data Export Directory,
    # falls dieses noch nicht existiert.
    #
    FileUtils.mkdir_p(path_object.directory) unless File.directory?(path_object.directory)

    path_object
  end

  # Speichern eines Datensatzes und entsprechende Verarbeitung für standardtisiertes Log Verhalten.
  #
  # === Attribute
  # *+resource+ - Der zu speichernde Datensatz.
  #
  # === Optionen
  # *+options+ - [Hash] für die Übergabe von zusätzlichen Attributen, die
  # für die Ausgabe im Log verwendet werden.
  #
  def save_resource(resource, options = {})
    options[:principal_id] = resource.principal_id if resource.respond_to?(:principal)
    options[:resource_class] = resource.class.to_s
    options[:resource_id] = resource.id.to_s
    options[:resource_attributes] = resource.attributes

    if resource.save
      msg = "Successfully saved #{resource.class} ##{resource.id} #{resource}."

      begin
        log(:info, msg, options)
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest
        options.delete(:resource_attributes)
        log(:info, msg, options)
      end
    else
      msg = "Unable to save #{resource.class} ##{resource.id} #{resource}: #{resource.errors.messages}"
      options[:error] = resource.errors.messages.to_s

      begin
        log(:error, msg, options)
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest
        options.delete(:resource_attributes)
        log(:error, msg, options)
      end
    end
  end

  def write_content_to_file(content, path)
    path = create_directory_recursively_unless_exists_and_return(path)

    file = File.open(path.path, 'w+')
    file.write content
    file.close
  end
end
