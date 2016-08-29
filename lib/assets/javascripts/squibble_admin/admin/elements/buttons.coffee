'use strict'

handleButtons = () ->
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
