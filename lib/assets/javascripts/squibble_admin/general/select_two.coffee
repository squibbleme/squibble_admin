'use strict'

handleSelect2 = () ->

  $('select:not(.processed)').each ( index ) ->
    $(this).select2
      allowClear: !$(this).closest('.form-group').hasClass('required')
    .addClass 'processed'

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
