$ ->
  $('body').on 'cocoon:after-insert', (e, insertedItem) ->

    insertedItem.find('input[type=checkbox]:not(.toggle, .make-switch), input[type=radio]:not(.toggle, .star, .make-switch)').uniform()
