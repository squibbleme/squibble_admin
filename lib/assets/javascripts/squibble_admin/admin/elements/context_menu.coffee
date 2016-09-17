'use strict'

jQuery ->

  $('.context-menu:not(.content-menu-processed)').each (index) ->
    that = $(this)
    that.contextmenu
      target: that.data('target')

    that.addClass('content-menu-processed')
    return
  return
