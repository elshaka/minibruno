ready = ->
  # metisMenu
  $('#side-menu').metisMenu()
  # Bootstrap field with errors
  $('.field-with-error').parent('.form-group').addClass 'has-error'
  # Selectizable
  $('.selectizable').selectize({
    sortField: 'text'
  })
  return

$(document).ready(ready)
$(document).on('page:load', ready)