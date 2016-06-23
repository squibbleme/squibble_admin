'use strict'

handleDateTimeInput = () ->

  ###
    @description Diese Methode kümmert sich darum, dass ein entsprechendes
    Attribut generiert wird anhand der neuen Elemente.

  ###
  handleDateAndTimeChange = ( that, date = null, time = null ) ->
    # Leeren des Zeitpunktes, wenn das Datum geleert wurde
    #
    if _.isNull(date) && _.isNull(time)
      formatedDateTime = null
    else
      formatedDateTime = "#{moment(date).format('YYYY-MM-DD')} #{moment(time, 'HH:mm:00').format('HH:mm:00')}"

    that.val(formatedDateTime)

    return

  $('input.date_time_picker:not(.processed)').each ( index ) ->

    that = $(this)

    # Auslesen des aktuellen Wertes.
    #
    date = moment(that.val()).format('YYYY-MM-DD')
    time = moment(that.val()).format('HH:mm:00')

    # Generieren des Markups für das
    # neue Formular Element.
    #
    element = $('''
        <div class="row">
          <div class="col-xs-6 col-lg-8 sq-date-time-picker-date">
            <input type="date" class="form-control" />
          </div>
          <div class="col-xs-6 col-lg-4 sq-date-time-picker-time">
            <input type="time" class="form-control" />
          </div>
        </div>
      ''')

    # 1. Ausblenden des eigentlichen Input Elementes
    #
    that
      .prop('type', 'hidden')
      .parent()
      .append(element)

    # 2. Hinzufügen des Markups für die zusätzlichen Input Elemente
    #    für :date und :time
    # 3. Setzen der Werte für :date und :time
    #
    element.find('input[type=time]')
      .prop('id', "#{that.prop('id')}_time")
      .prop('name', that.prop('name').replace(']', '_time]'))
      .prop('required', $(this).hasClass('required'))
      .val(time)
      .change( () ->
        # Evaluation des Datums
        #
        date = element.find('input[type=date]').val()
        time = $(this).val()

        # Ausführen des Callbacks
        #
        if _.isEmpty(time)
          handleDateAndTimeChange(that)
          element.find('input[type=date]').val(null)
        else
          handleDateAndTimeChange(that, date, time)
        return
      )

    element.find('input[type=date]')
      .prop('id', "#{that.prop('id')}_date")
      .prop('name', that.prop('name').replace(']', '_date]'))
      .prop('required', $(this).hasClass('required'))
      .val(date)
      .change( () ->
        # Evaluation des Datums
        #
        date = $(this).val()
        time = element.find('input[type=time]').val()

        # Ausführen des Callbacks
        #
        if _.isEmpty(date)
          handleDateAndTimeChange(that)
          element.find('input[type=time]').val(null)
        else
          handleDateAndTimeChange(that, date, time)
        return
      )

    # Markiern des verarbeiteten Elementes als :processed
    #
    that.addClass 'processed'

    return

$(document).on 'ready page:change', (event) ->
  handleDateTimeInput()

$(document).on 'cocoon:after-insert', (e, insertedItem) ->
  handleDateTimeInput()
