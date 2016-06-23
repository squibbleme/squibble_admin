'use strict'

$(document).on 'ready page:change', (event) ->


  # Bei der Änderung eines Datei Inputs, der bereits über eine verknüpfte Datei
  # verfügt, soll der Dateiname entfernt werden.
  #
  $('input.sq_file').change (e) ->
    console.log 'changed'
    console.log $(this).parent().find('span.sq-file-input-file-name').remove()
