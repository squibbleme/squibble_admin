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

      entry = Elasticsearch::LogEntry.new(class: self.class, level: level, message: message, options: options)
      entry.save

      eval("Rails.logger.application.#{level} \'#{message}\'")

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

  def write_content_to_file(content, path)
    path = create_directory_recursively_unless_exists_and_return(path)

    file = File.open(path.path, 'w+')
    file.write content
    file.close
  end
end
