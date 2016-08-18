'use strict'

handleFormValidation = () ->

  $('form.simple_form').validate
    highlight: ( element ) ->
      $(element).closest '.form-group'
                .removeClass 'has-success'
                .addClass 'has-error'
    unhighlight: ( element ) ->
      $(element).closest '.form-group'
                .removeClass 'has-error'
                .addClass 'has-success'
    errorElement: 'span'
    errorClass: 'help-block'
    submitHandler: (form) ->

      # Starten von BlockUI
      #
      $.blockUI
        message: '<i class="fa fa-spin fa-spinner fa-2x"></i> Bitte warten ...'
        css:
          backgroundColor: 'transparent'
          color: '#fff'
          border: 'none'

      # Übermitteln des Formulars
      #
      form.submit()

jQuery ->
  handleFormValidation()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleFormValidation()
