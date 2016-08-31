# Dieses Modul kümmert sich darum, dass Standardfunktionalitäten
# für die Handhabung und Formatierung von CSV Datensätzen.
#
module CSVService
  require 'csv'
  include ActionView::Helpers::NumberHelper
  include SquibbleService

  private

  def csv_format_number(value)
    number_with_precision(value, precision: 10, separator: ',', delimiter: '')
  end

  def csv_format_percentage(value)
    number_to_percentage(value)
  end

  def csv_format_price(value)
    number_with_precision(value, precision: 2, separator: ',', delimiter: '')
  end

  def csv_format_date(date)
    I18n.l(date.to_date, format: :system)
  end

  def csv_format_time(time)
    I18n.l(time.to_time, format: :system_only_time)
  end

  def csv_content_timestamps(resource)
    [
      csv_format_date(resource.created_at), csv_format_time(resource.created_at),
      csv_format_date(resource.updated_at), csv_format_time(resource.updated_at)
    ]
  end

  # Im Folgenden werden Methoden definiert, die für die
  # Ausgabe der .csv Dateien benötigt werden.
  #
  # ===========================================================================

  # Diese Methode kümmert sich darum, dass die standartisierte Ausgabe der
  # Ausgabe in eine .csv Datei korrekt ausgeführt werden kann. Dazu werden die benötigten
  # Attribute :collection und :file_path übergeben.
  #
  # === Attribute
  # *+collection+
  # *+file_path+ - Speicherort der .csv Datei
  #
  def _handle_default_execution(collection, file_path)
    # Prüfe, ob mit der mitgegebenen :collection
    # fortgefahren werden kann, oder brich ab.
    #
    return unless _check_collection(collection)

    # Setze Pfad und Dateinamen für zu generierendes CSV-File
    #
    csvfile_path = create_directory_recursively_unless_exists_and_return(file_path).path

    # Falls die Datei bereits existiert, wird diese gelöscht, damit diese neu generiert
    # werden kann.
    #
    File.delete(csvfile_path) if File.exist?(csvfile_path) && File.file?(csvfile_path)

    # Generiere neues CSV-File
    #
    CSV.open(csvfile_path, 'wb', force_quotes: true) do |csv|
      _add_files_to_csv(csv, collection)
    end
  end


  # Hinzufügen von Datensätzen in die eigentliche .csv Datei
  #
  # === Attribute
  # *+csvfile+ - Geöffnete .csv Datei
  # *+collection+ - Liste von Datensätzen
  #
  def _add_files_to_csv(csvfile, collection)
    # Füge in der ersten Zeile die Beschriftungen
    # der Attribute ein
    #
    csvfile << self.class::CSV_ENTRY_OPERATION::CSV_HEADER.map(&:to_s)
    # ap self.class::CSV_ENTRY_OPERATION::CSV_HEADER.map(&:to_s)

    # Resette den Counter, um sicherzustellen, dass dieser
    # bei 0 beginnt.
    #
    csvfile_counter = 0

    # Iteriere über alle Fahrten und füge diese zum CSV-File hinzu.
    #
    collection.each do |resource|
      op = self.class::CSV_ENTRY_OPERATION.new(resource)
      object = op.perform

      if op.succeeded?
        csvfile << object
        # ap object
      else
        msg = "Unable to create a valid csv entry object: #{op.message}"
        log(:error, msg)
        raise CSVService::CSVEntryOperationError, msg
      end

      # Counter der zählt, wieviele Einträge zum CSV-File
      # hinzugefügt wurden.
      #
      csvfile_counter += 1
    end

    msg = "Successfully added #{csvfile_counter} of #{collection.count} to csv file."
    log :debug, msg
  end

  # Prüfung der übergebenen :collection
  #
  # === Attribute
  # *+collection+ - Liste von Datensätzen
  #
  def _check_collection(collection)
    # Prüfe, ob die mitgegebene :collection Elemente enthält.
    #
    if collection.empty?
      msg = 'The given :collection is empty. Operation terminated.'
      log :debug, msg

      raise CSVService::EmptyCollectionException, msg
    end

    # Prüfe, ob all Elemente der :collection auch vom Typ
    # Business::AccountingRecord sind.
    #
    collection.each do |resource|
      next if resource.is_a?(self.class::CURRENT_RESOURCE_CLASS)
      msg = "The given :collection holds resources of other types than #{self.class::CURRENT_RESOURCE_CLASS}"
      log :error, msg

      raise CSVService::CollectionContainsInvalidTypeException, msg
    end

    # Die Prüfungen sind nicht fehlgeschlagen,
    # die :collection kann weiter benutzt werden.
    #
    true
  end
end
class CSVService::Exception < Exception; end
class CSVService::CSVEntryOperationError < CSVService::Exception; end
class CSVService::EmptyCollectionException < CSVService::Exception; end
class CSVService::CollectionContainsInvalidTypeException < CSVService::Exception; end
