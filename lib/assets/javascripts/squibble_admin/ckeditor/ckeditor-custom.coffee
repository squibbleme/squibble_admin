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
    asset_name = $(this).data('ckeditor-asset-name')
    language = $(this).data('ckeditor-language')
    baseHref = $(this).data('ckeditor-base-href')

    assets_name = $(this).data('ckeditor-assets-name') # Beinhaltet mehrere Pfade zu kompletten CSS Dateien

    attrs = {}

    if baseHref
      attrs.baseHref = "http://#{baseHref}"

    if height
      attrs.height = height

    # Es wird ein Array von CSS Assets aktiviert
    if assets_name
      attrs.contentsCss = assets_name.split ','
    else
      attrs.contentsCss = "http://#{window.location.hostname}/assets/frontend.css"

    if language
      attrs.language = language

    $(this).ckeditor(
      attrs
    )

    $(this).addClass 'processed'
