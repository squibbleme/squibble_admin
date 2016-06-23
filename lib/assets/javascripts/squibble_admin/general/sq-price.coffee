'use strict'

$(document).on 'ready page:change', (event) ->

  currency = $('meta[name=sq-current-principal-currency-unit]').attr 'content'

  $('.sq-price:not(.processed)').each ( index ) ->
    value = s.numberFormat(s.toNumber($(this).text(), 2), 2, '.', ' ')

    $(this).text "#{value} #{currency}"
      .addClass 'processed'
    return
