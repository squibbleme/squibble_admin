'use strict'

$(document).on 'turbolinks:request-start', (e) ->

  # Starten von BlockUI
  #
  $.blockUI
    message: '<i class="fa fa-spin fa-spinner fa-2x"></i> Bitte warten ...'
    css:
      backgroundColor: 'transparent'
      color: '#fff'
      border: 'none'
