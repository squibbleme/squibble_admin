'use strict'

executeSearch = () ->

  $('form.search-form input:not(.processed)').on 'keyup', () ->
    that = $(this)
    that.addClass 'processed'

    that.autocomplete
      source: (request, response) ->
        $.ajax
          url: that.data('url')
          data:
            query: that.val()
          success: (data) ->
            response _.flatten(
              _.map(data, (term) ->
                _.map(term.options, (option) ->
                  option.text
                )
              )
            )
        return
      minLength: 2
    return

  $('form.search-form').on('submit', ( e ) ->
    Turbolinks.visit @action + (if @action.indexOf('?') == -1 then '?' else '&') + $(this).serialize()
    false
  )

$(document).on 'page:change', (event) ->
  executeSearch()
