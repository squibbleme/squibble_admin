'use strict'

jQuery ->

  $('.sq-time').each ( index ) ->
    # Setzen des Formates für die Ausgabe in MomentJS
    #
    format = $(this).data 'sq-format'
    if _.isUndefined(format)
      format = 'LLL'

    # Ausgabe des Inhaltes über MomentJS
    #
    $(this).text moment($(this).data('sq-datetime')).format(format)
    return
