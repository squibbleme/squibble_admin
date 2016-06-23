'use strict'

$(document).on 'ready page:change', (event) ->

  $('.sq-distance-to-time:not(.processed)').each ( index ) ->

    input = moment($(this).data('sq-distance-to-time'))

    $(this).text(moment().to(input))
           .addClass 'processed'
