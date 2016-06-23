'use strict'

handleDateInput = () ->

  if /Mobi/.test(navigator.userAgent)
    # Mobiles Gerät
    #
    $('input.date_picker').each ( index ) ->
      $(this).val moment($(this).val()).format 'YYYY-MM-DD'
      $(this).prop 'type', 'date'

  else
    # Nicht mobiles Gerät
    #
    if jQuery().datepicker

      $('input.date_picker:not(.processed)').each ( index ) ->
        $(this).attr('readonly', true)
          .datepicker(
            format: 'yyyy-mm-dd'
            language: $('html').attr('lang')
            autoclose: true
            todayBtn: 'linked'
            todayHighlight: true
            closeText: 'clear'
            calendarWeeks: true
            clearBtn: !$(this).hasClass('required')
            orientation: 'bottom right'
          ).addClass 'processed'

        return if _.isEmpty($(this).val())

        $(this).val moment($(this).val()).format 'YYYY-MM-DD'



$(document).on 'ready page:change', (event) ->
  handleDateInput()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleDateInput()
