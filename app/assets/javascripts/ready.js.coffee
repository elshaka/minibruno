ready = ->
  # metisMenu
  $('#side-menu').metisMenu()

  # Bootstrap field with errors
  $('.field-with-error').parent('.form-group').addClass 'has-error'

  # Selectizable
  $('.selectizable').selectize()

  # DateTimePicker
  $('input.datepicker-b3').focus ->
    $(this).datetimepicker {
      format: 'YYYY-MM-DD',
      pickTime: false,
      language: 'es'
    }
    return
  $('input.datetimepicker-b3').focus ->
    $(this).datetimepicker {
      format: 'YYYY-MM-DD hh:mm A',
      pick12HourFormat: true,
      sideBySide: true,
      language: 'es',
    }
    return

  # Time range checkboxes
  time_range_checkboxes = $('.time_range_checkbox')
  time_range_checkboxes.on 'change', ->
    checkbox = $(this)
    checked = checkbox.is(':checked')
    checkbox.parents('form').find('.datetime').toggle checked
    checkbox.parents('form').find('.date').toggle not checked
    return
  time_range_checkboxes.trigger 'change'

  # Dashboard
  clearTimeout window.stats_timeout
  if location.pathname is '/'
    window.get_stats()

  return

$(document).ready ready
$(document).on 'page:load', ready
