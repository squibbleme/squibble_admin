'use strict'

jQuery ->
  currency = $('meta[name=sq-current-principal-currency-unit]').attr 'content'

  $('.sq-price').each ( index ) ->
    value = s.numberFormat(s.toNumber($(this).text(), 2), 2, '.', ' ')

    $(this).text "#{value} #{currency}"
    return
