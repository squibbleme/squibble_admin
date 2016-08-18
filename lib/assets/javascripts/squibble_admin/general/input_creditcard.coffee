'use strict'

handleCreditCardInput = () ->
  $('input.sq-credit-card:not(.processed)').each ( index ) ->
    that = $(this)

    that.validateCreditCard((result) ->

      if result.valid
        if that.val()
          that.closest '.form-group'
              .removeClass 'has-error'
              .addClass 'has-success'

        # Entsprechenden Kreditkarten Typ auswählen
        #
        switch result.card_type.name
          when 'amex' then card_type = 'american_express'
          else card_type = result.card_type.name

        that.closest('form').find("input.sq-credit-card-brand[value='#{card_type}']")
            .attr('checked', true)

        # Entfernen des aktuellen Icons und hinzufügen des
        # Icons der Kreditkarte
        #
        that.closest('.input-group')
            .find('.input-group-addon i.fa')
            .remove()

        that.closest('.input-group')
            .addClass("sq-credit-card-#{result.card_type.name}")
            .find('.input-group-addon')
            .append("<i class='fa fa-cc-#{result.card_type.name}'></i>")
      else
        if that.val()
          that.closest '.form-group'
              .removeClass 'has-success'
              .addClass 'has-error'

        # Es wurde keine gültige Kreditkartennummer eingegeben.
        # Das Icon wird auf "fa-cc" gesetzt.
        #
        that.closest('.input-group')
          .find('.input-group-addon i.fa')
          .remove()

        that.closest('.input-group')
            .addClass("sq-credit-card-undefined")
            .find('.input-group-addon')
            .append('<i class="fa fa-cc"></i>')

    )

    # Hinzufügen der Klasse zur Markierung der erfolgreichen
    # Verarbeitung des Elements.
    #
    that.addClass 'processed'

    return

jQuery ->
  handleCreditCardInput()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleCreditCardInput()
