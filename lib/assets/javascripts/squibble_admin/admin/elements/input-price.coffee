'use strict'

###
  @description Sämtliche Preis Elemente (as: :price) werden mit der
  aktuellen Währung markiert. Zudem wird priceFormat ausgeführt, damit
  die Eingabe bereits clientseitig validiert werden kann.
###
handlePriceInput = () ->
  currency = $('meta[name=sq-current-principal-currency-unit]').attr 'content'

  $('input.price:not(.processed)').each ( index ) ->
    that = $(this)

    # Anpassen des Markups, damit das Addon korrekt
    # dargestellt wird.
    #
    that.wrap "<div class='input-group price'></div>"

    # Hinzufügen des Addons für die Darstellung
    # der Währung.
    #
    that.after "<span class='input-group-addon'>#{currency}</span>"

    # Hinzufügen der Klasse zur Markierung der erfolgreichen
    # Verarbeitung des Elements.
    #
    that.addClass 'processed'

    return

  $('input.price').priceFormat
    prefix: ''
    thousandsSeparator: ''

$(document).on 'ready page:change', (event) ->
  handlePriceInput()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handlePriceInput()
