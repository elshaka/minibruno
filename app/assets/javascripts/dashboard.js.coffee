window.get_stats = ->
  $.getJSON 'dashboard/stats', window.update_stats
  return

window.update_stats = (data) ->
  update_div = (temp, div_id, control_div_id) ->
    if temp?
      $(div_id).html("#{temp.value} °F")
      if temp.set_point?
        $(control_div_id).html("Setpoint: #{temp.set_point} °F <span class='label label-#{if temp.auto then 'success' else 'danger'} auto-label'>#{if temp.auto then 'Auto' else 'Manual'}</span>")
    else
      $(div_id).html("-- °F")
      $(control_div_id).html("--")

  update_div(data.init_temp, '#init-temp', '#init-temp-control')
  update_div(data.mid_temp, '#mid-temp', '#mid-temp-control')
  update_div(data.final_temp, '#final-temp', '#final-temp-control')
  update_div(data.vapor_temp, '#vapor-temp', '#vapor-temp-control')

  window.stats_timeout = setTimeout window.get_stats, 30000
  return
