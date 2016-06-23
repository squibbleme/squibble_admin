'use strict'

window.formatFileSize = (size) ->
  sizes = [
    ' Bytes'
    ' KB'
    ' MB'
    ' GB'
    ' TB'
    ' PB'
    ' EB'
    ' ZB'
    ' YB'
  ]
  i = 1
  while i < sizes.length
    if size < 1024 ** i
      return Math.round(size / 1024 ** (i - 1) * 100) / 100 + sizes[i - 1]
    i++
  size
