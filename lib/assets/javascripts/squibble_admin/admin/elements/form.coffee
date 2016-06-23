'use strict'

handleFormValidation = () ->

  $('form').validate
    highlight: ( element ) ->
      $(element).closest '.form-group'
        .addClass 'has-error'
    unhighlight: ( element ) ->
      $(element).closest '.form-group'
        .removeClass 'has-error'
    errorElement: 'span'
    errorClass: 'help-block'

$(document).on 'ready page:change', (event) ->
  handleFormValidation()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleFormValidation()
