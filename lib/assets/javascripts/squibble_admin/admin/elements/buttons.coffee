'use strict'

handleButtons = () ->
  ###
    @description    Hinzufügen eines zusätzlichen Feldes in das Formular für das
                    Löschen eines Datensatzes auf der Übersichtsseite.
                    Das Formularfeld heisst :_callback_url und enthält die aktuelle URL als
                    Wert.

    @author         Patrick Lehmann <lehmann@squibble.me>
    @date           2016-10-10
    @changelog
                    2016-10-10: INIT
  ###
  $('button.sq-destroy-btn').each ( index ) ->
    that = $(this)

    element = that.closest('form').append('<input type="hidden" name="_callback_url" />')
      .find('[name="_callback_url"]')
      .attr('value', $(location)[0].href)

  $('button.sq-destroy-btn').click (e) ->

    $.blockUI
      message: '<i class="fa fa-spin fa-spinner fa-2x"></i> Datensatz wird gelöscht. Bitte warten ...'
      css:
        backgroundColor: 'transparent'
        color: '#fff'
        border: 'none'

jQuery ->
  handleButtons()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleButtons()
