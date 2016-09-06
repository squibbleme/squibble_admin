# Dieser Service stellt Standard Methoden für die Arbeit mit
# Operations zur Verfügung.
#
# Über include OperationsService können diese eingebunden werden.
#
module OperationsService
  private

  #
  # === Attribute
  # *+resource+ Aktuelle Resource, die bearbeitet werden soll.
  # *+path+ - Pfad der Quelldatei
  # *+key+ - Als welches Attribut soll die Ressource mit der
  #   Datei verbunden werden.
  #
  def create_backend_document(resource, path, key)
    # Erstellen des Dokuments
    #
    document = Backend::Document.new(
      principal_id: resource.principal_id,
      file: Pathname.new(path).open,
      label: class_translations(:operations, 'document.label', model: resource, raise: true)
    )

    # Verbinden des Dokumentes
    # mit der entsprechenden Ressource
    #
    begin
      eval("document.#{key} = resource")
    rescue NoMethodError
      raise ArgumentError.new(":#{key} is not allowed to connect to a document.")
    else
      # :description
      begin
        desc_text = class_translations(:operations, 'document.description',
                                       model: resource, generated_at: I18n.l(Time.zone.now),
                                       raise: true
        )
      rescue I18n::MissingTranslationData
      else
        document.description = desc_text
      end

      # :internal_description
      begin
        int_desc_text = class_translations(:operations, 'document.internal_description',
                                           model: resource,
                                           raise: true
        )
      rescue I18n::MissingTranslationData
      else
        document.internal_description = int_desc_text
      end

      if document.save

        # Verbinden des Tags
        #
        document.tags.push Backend::Document::Tag.find_or_create_by(
                             principal_id: resource.principal_id,
                             label: Settings.default.backend.document.tag.automatically_generated_label
                           )

        log(:info, 'Successfully stored generated file in document storage.', principal_id: resource.principal_id, document_id: document.id)

        # Löschen der zuvor angelegten Datei
        #
        if File.exist?(path)
          File.delete(path)
          log(:info, "Deleted file #{path}")
        end

        return true
      else
        log(:error, 'Could not store file in document storage.', principal_id: resource.principal_id, errors: document.errors.messages)
        return false
      end

    end
  end
end
