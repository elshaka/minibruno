ready = ->
  # metisMenu
  $('#side-menu').metisMenu()
  # Bootstrap field with errors
  $('.field-with-error').parent('.form-group').addClass 'has-error'
  # Selectizable
  $('.selectizable').selectize()
  # Datepicker
  datepickers = $('.datepicker')
  datepickers.datetimepicker({
    format: 'YYYY-MM-DD',
    pickTime: false,
    language: 'es'
  })
  datepickers.setDate(new Date())

  return

$(document).ready(ready)
$(document).on('page:load', ready)
