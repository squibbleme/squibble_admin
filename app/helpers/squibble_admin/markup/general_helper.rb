module SquibbleAdmin::Markup::GeneralHelper
  # Diese Methode retourniert einen Adresstag
  # für die übergebene Adresse.
  #
  # === Attribute
  # *+address+
  #
  def address_tag(address, options = {})
    render partial: 'helpers/squibble_admin/markup/general_helper/address_tag',
           locals: { resource: address, options: options }
  end

  def async_background_processing(show, resource)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing',
           locals: {show: show, resource: resource}
  end

  def async_background_processing_icon(state)
    render partial: 'helpers/squibble_admin/markup/general_helper/async_background_processing_icon',
           locals: {state: state}
  end

  def sq_image_responsive_tag(source, title = nil, options = {})
    image_tag(source, class: [ 'img-responsive', options[:class] ], alt: title)
  end

  # Diese Methode retourniert die Standard ID
  # für eine Objekt. Dieser Helper soll auf Übersichts-Seiten
  # verwendet werden, damit eine konsistente ID für die entsprechenden
  # Attribute generiert werden kann.
  #
  # === Attribute
  # *+resource+
  #
  # === Beispiel
  # %tr{ default_overview_resource_attributes( resource ), data: { other: true } }
  #
  def default_overview_resource_attributes(resource)
    { id: "sq_collection:#{resource.id}" }
  end

  # Diese Methode kümmert sich um die einheitliche Ausgabe der Timestamps
  # für die Detailseiten von Datensätzen.
  def show_timestamps(show, resourze = resource)
    render partial: 'helpers/squibble_admin/markup/general_helper/show_timestamps',
           locals: { resource: resource, show: show }
  end

  #
  # === Attribute
  # *+type+ Video Type: Youtube / Vimeo
  # *+code+ Video Code
  #
  # === Optionen
  # *+autoplay+ Soll das Video automatisch gestartet werden oder nicht? Standard: false
  #
  # *+controls+ Werte: 0, 1 oder 2. Die Standardeinstellung ist 1. Dieser Parameter legt fest, ob die Steuerung des Videoplayers eingeblendet wird.
  #             Bei IFrame-Einbettungen, die einen Flash Player laden, definiert der Parameter außerdem, wann die Steuerung im Player angezeigt
  #             und wann der Player geladen wird:
  #
  #             controls=0 – Steuerung des Players wird nicht angezeigt. Bei IFrame-Einbettungen wird der Flash Player sofort geladen.

  #             controls=1 – Steuerung des Players wird angezeigt. Bei IFrame-Einbettungen wird die Steuerung sofort angezeigt, und
  #             auch der Flash Player wird sofort geladen.

  #             controls=2 – Steuerung des Players wird angezeigt. Bei IFrame-Einbettungen wird die Steuerung angezeigt und der Flash
  #             Player wird geladen, nachdem der Nutzer die Videowiedergabe gestartet hat.
  #
  # *+loop+ Werte: 0 oder 1. Die Standardeinstellung ist 0. Falls der Player zur Wiedergabe eines einzelnen Videos konfiguriert ist,
  #         wird dieses Video fortwährend wiederholt, wenn dieser Parameter auf 1 gesetzt wird. Falls es sich um einen Playlist-Player
  #         oder einen benutzerdefinierten Player handelt, wird die gesamte Playlist abgespielt und anschließend vollständig wiederholt.
  #
  # *+playlist+ Bei dem Wert für diesen Parameter handelt es sich um eine durch Kommas getrennte Liste von Video-IDs für die Wiedergabe.
  #             Wenn du einen Wert festlegst, wird zuerst das Video abgespielt, das über die VIDEO_ID im URL-Pfad angegeben wird.
  #             Anschließend folgen die im playlist-Parameter angegebenen Videos.
  #
  # *+showinfo+ Werte: 0 oder 1. Der Standardwert des Parameters ist 1. Wenn du den Parameterwert auf 0 setzt, werden Informationen wie z. B.
  #             der Videotitel oder der Name des Uploaders nicht im Player angezeigt, bevor die Videowiedergabe beginnt.
  #             Wenn der Player eine Playlist lädt und du den Parameterwert ausdrücklich auf 1 gesetzt hast, zeigt der Player nach dem Ladevorgang
  #             auch Thumbnails für die Videos in der jeweiligen Playlist an. Diese Funktion wird ausschließlich für den AS3-Player unterstützt, da
  #             dies der einzige Player ist, der eine Playlist laden kann.
  #
  def video_container(type, code, options = {})
    Rails.cache.fetch [ 'SquibbleAdmin::Markup::GeneralHelper.video_container', code, type, options] do
      require 'uri'

      options[:autoplay] = ( options[:autoplay].present? ? options[:autoplay] : false)
      options[:controls] = ( options[:controls].present? ? options[:controls] : 0)
      options[:loop] = ( options[:loop].present? ? options[:loop] : 0)
      options[:playlist] = ( options[:playlist].present? ? options[:playlist] : code)
      options[:showinfo] = ( options[:showinfo].present? ? options[:showinfo] : 1)

      options[:width] = '100%'
      options[:height] = '100%'
      options[:frameborder] = 0
      options[:allowfullscreen] = true
      options[:webkitallowfullscreen] = true
      options[:mozallowfullscreen] = true

      case type.to_sym
      when :youtube
        uri = URI.parse("https://www.youtube.com/embed/#{code}")
        uri.query = URI.encode_www_form(options)

        options[:src] = uri
      when :vimeo
        uri = URI.parse("https://player.vimeo.com/video/#{code}")
        uri.query = URI.encode_www_form(options)
        uri.query = URI.encode_www_form({
          badge: 0, title: 0, byline: 0, portrait: 0
        })
        options[:src] = uri
      end

      render partial: 'helpers/squibble_admin/markup/general_helper/video_container',
             locals: { code: code, type: type, options: options }

    end
  end
end
