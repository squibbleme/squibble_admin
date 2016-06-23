'use strict'

handleNumberInput = () ->

  $('input.number:not(.processed)').each ( index ) ->
    that = $(this)

    # Hinzufügen der input group, wenn das Attribut
    # :data-unit gesetzt ist.
    #
    if that.data().unit

      # Anpassen des Markups, damit das Addon korrekt
      # dargestellt wird.
      #
      that.wrap "<div class='input-group price'></div>"

      # Hinzufügen des Addons für die Darstellung
      # der Einheit.
      #
      that.after "<span class='input-group-addon'>#{that.data().unit}</span>"

      # Hinzufügen der Klasse zur Markierung der erfolgreichen
      # Verarbeitung des Elements.
      #
      that.addClass 'processed'

    return
$(document).on 'ready page:change', (event) ->
  handleNumberInput()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleNumberInput()
