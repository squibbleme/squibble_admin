'use strict'

handlePercentageInput = () ->
  $('input.percentage:not(.processed)').each ( index ) ->
    that = $(this)

    # Anpassen des Markups, damit das Addon korrekt
    # dargestellt wird.
    #
    that.wrap "<div class='input-group decimal'></div>"

    that.after "<span class='input-group-addon'>%</span>"

    # Hinzufügen der Klasse zur Markierung der erfolgreichen
    # Verarbeitung des Elements.
    #
    that.addClass 'processed'

    return

jQuery ->
  handlePercentageInput()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handlePercentageInput()
