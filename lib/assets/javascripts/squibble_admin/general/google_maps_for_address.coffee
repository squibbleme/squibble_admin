'use strict'

googleMapsForAddress = () ->

  $('.google-map-for-address:not(.processed)').each ( index ) ->
    that = $(this)

    data = that.data()

    # Standard Zoom
    #
    zoom = 15
    zoom = data.optionsZoom unless _.isUndefined(data.optionsZoom)

    # Generieren der Karte
    #
    mapbg = new GMaps
      div: document.getElementById(that.attr('id'))
      lat: data.latitude
      lng: data.longitude
      scrollwheel: false
      zoom: zoom

    # Hinzufügen des Markers
    #
    mapbg.addMarker
      lat: data.latitude
      lng: data.longitude
      title: data.fullAddress
      infoWindow:
        content: data.fullAddress

    that.addClass 'processed'

jQuery ->
  googleMapsForAddress()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  googleMapsForAddress()
