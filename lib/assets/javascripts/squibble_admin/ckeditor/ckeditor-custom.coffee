'use strict'

jQuery ->
  # Diese Methode kümmert sich darum, dass, sofern das Attribute
  # data-ckeditor-asset-name gesetzt ist, der Wert an den entsprechenden
  # CKEditor übergeben wird. Somit kann das gewünschte Layout geladen werden.
  #
  # Ist das Attribute data-ckeditor-language gesetzt, kann so die Sprache definiert
  # werden.
  #
  # ---------------------------------------------------------------------------------
  $('textarea.ckeditor:not(.processed)').each ->
    height = $(this).data('ckeditor-height')
    language = $(this).data('ckeditor-language')
    baseHref = $(this).data('ckeditor-base-href')

    # Beinhaltet mehrere Pfade zu kompletten CSS Dateien
    #
    assets_name = $(this).data('ckeditor-assets-name')

    attrs = {}

    if baseHref
      attrs.baseHref = baseHref

    if height
      attrs.height = height

    # Es wird ein Array von CSS Assets aktiviert
    attrs.contentsCss = new Array

    _.each assets_name.split(','), (asset_name) ->
      attrs.contentsCss.push asset_name.replace(attrs.baseHref, '')

    if language
      attrs.language = language

    $(this).ckeditor(attrs)

    $(this).addClass 'processed'

  return
