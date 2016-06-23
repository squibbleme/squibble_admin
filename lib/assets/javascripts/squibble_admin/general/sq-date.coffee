'use strict'

$(document).on 'ready page:change', (event) ->

  $('.sq-date').each ( index ) ->

    # Setzen des Formates für die Ausgabe in MomentJS
    #
    format = $(this).data 'sq-format'
    if _.isUndefined(format)
      format = 'L'

    # Ausgabe des Inhaltes über MomentJS
    #
    value = $(this).data('sq-date')
    if _.isEmpty(value)
      $(this).text '---'
    else
      $(this).text moment($(this).data('sq-date')).format(format)
    return
