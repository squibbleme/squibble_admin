'use strict'

handleFormValidation = () ->

  $('form.simple_form').each () ->
    $(this).validate
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
          message: '<i class="fa fa-spin fa-smile-o fa-2x"></i> Please wait and smile!'
          css:
            backgroundColor: 'transparent'
            color: '#fff'
            border: 'none'

        # Übermitteln des Formulars
        #
        form.submit()
    return

jQuery ->
  handleFormValidation()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleFormValidation()
