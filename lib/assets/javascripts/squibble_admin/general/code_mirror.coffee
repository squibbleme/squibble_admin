'use strict'

jQuery ->

  $('textarea.codemirror').each ( element ) ->
    unless $(this).hasClass('processed')
      $(this).addClass 'processed'

      element = document.getElementById $(this).attr('id')

      CodeMirror.fromTextArea element,
        lineNumbers: true
        mode: $(this).attr('type')
        matchBrackets: true
        readOnly: $(this).attr('readonly')
        tabSize: 2


      console.log if !_.isUndefined($(this).data().height) then $(this).data().height else null
