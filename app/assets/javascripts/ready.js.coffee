ready = ->
  # metisMenu
  $('#side-menu').metisMenu()
  # Bootstrap field with errors
  $('.field-with-error').parent('.form-group').addClass 'has-error'
  # Selectizable
  $('.selectizable').selectize()
  # DateTimePicker
  datepickers = $('.datepicker-b3')
  datepickers.datetimepicker({
    format: 'YYYY-MM-DD',
    pickTime: false,
    language: 'es'
  })
  datepickers.each ->
    $(this).data('DateTimePicker').setDate new Date
    return
  timepickers = $('.timepicker-b3')
  timepickers.datetimepicker({
    format: 'hh:mm A',
    pick12HourFormat: true,
    pickDate: false,
    language: 'es',
  })
  datetimepickers = $('.datetimepicker-b3')
  datetimepickers.datetimepicker({
    format: 'YYYY-MM-DD hh:mm A',
    pick12HourFormat: true,
    sideBySide: true,
    language: 'es',
  })
  time_range_checkboxes = $('.time_range_checkbox')
  time_range_checkboxes.on 'change', ->
    checkbox = $(this)
    checked = checkbox.is(':checked')
    checkbox.parents('form').find('.datetime').toggle checked
    checkbox.parents('form').find('.date').toggle not checked
    return
  time_range_checkboxes.trigger 'change'
  return

$(document).ready(ready)
$(document).on('page:load', ready)
