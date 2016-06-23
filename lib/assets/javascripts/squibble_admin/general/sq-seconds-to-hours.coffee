'use strict'

$(document).on 'ready page:change', (event) ->

  DAY_IN_SECONDS = 24 * 3600

  $('.sq-seconds-to-date:not(.processed)').each ( index ) ->
    $(this).addClass 'processed'

    # Auslesen des Inputs
    #
    input = s.toNumber($(this).data('seconds'))

    # Auslesen des Formates
    #
    format = $(this).data().format

    if _.isUndefined(format)

      # Der Input ist 0
      #
      if _.isEqual(input, 0)
        $(this).text '00:00:00'

      # Der Input liegt unter einem Tag (24 Stunden).
      #
      else if input <= DAY_IN_SECONDS
        $(this).text moment.duration(input, 'seconds').format('hh:mm:ss', trim: false)

      # Der Input übersteigt einen Tag.
      #
      else
        $(this).text moment.duration(input, 'seconds').format('D Tage hh:mm:ss', trim: false)

    else

      # Es wurde ein Format übergeben
      #

      # Das übergebene Format ist hhh:mm:ss. Ist der Input aber kleiner als 24 Stunden, so wird
      # das Format entsprechend angepasst, damit nicht 000: steht.
      #
      if _.isEqual(format, 'hhh:mm:ss')

        format = 'hh:mm:ss' if input <= DAY_IN_SECONDS



      $(this).text moment.duration(input, 'seconds').format(format, trim: false)
