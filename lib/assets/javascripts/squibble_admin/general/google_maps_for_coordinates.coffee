'use strict'

googleMapsForCoordinates = () ->

  $('.google-map-for-coordinates:not(.processed)').each ( index ) ->
    that = $(this)

    data = that.data()

    # Standard Zoom
    #
    zoom = data.optionsZoom unless _.isUndefined(data.optionsZoom)

    mapOptions =
      div: document.getElementById(that.attr('id'))
      lat: data.latitude
      lng: data.longitude
      scrollwheel: data.scrollwheel
      zoom: zoom
      draggable: data.draggable


    # Generieren der Karte
    #
    mapbg = new GMaps( mapOptions )

    markerLabel = data.optionsMarkerLabel unless _.isUndefined(data.optionsMarkerLabel)
    markerContent = data.optionsMarkerContent unless _.isUndefined(data.optionsMarkerContent)

    # Hinzufügen des Markers
    #

    if _.isEmpty markerContent

      mapbg.addMarker
        lat: data.latitude
        lng: data.longitude
        title: markerLabel
    else
      mapbg.addMarker
        lat: data.latitude
        lng: data.longitude
        title: markerLabel
        infoWindow:
          content: markerContent

    that.addClass 'processed'

jQuery ->
  googleMapsForCoordinates()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  googleMapsForCoordinates()
