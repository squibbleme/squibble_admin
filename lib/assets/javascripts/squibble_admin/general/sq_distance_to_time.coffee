'use strict'

jQuery ->

  $('.sq-distance-to-time:not(.processed)').each ( index ) ->
    input = moment($(this).data('sq-distance-to-time'))

    $(this).text(moment().to(input))
           .addClass 'processed'
