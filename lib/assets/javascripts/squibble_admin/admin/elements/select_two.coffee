'use strict'

handleSelect2 = () ->

  if !/Mobi/.test(navigator.userAgent)

    $('select:not(.processed)').each ( index ) ->
      $(this).select2(
        allowClear: !$(this).closest('.form-group').hasClass('required'),
        width: '100%'
      ).addClass 'processed'

      #   $('input.select_two_array').each ( index ) ->

      #     $(this).select2(
      #       tags: true
      #       tokenSeparators: [',']
      #     )

  return

jQuery ->
  handleSelect2()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleSelect2()