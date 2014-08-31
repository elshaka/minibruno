$ ->
  $(window).bind "load resize", ->
    topOffset = 50
    width = (if (@window.innerWidth > 0) then @window.innerWidth else @screen.width)
    if width < 768
      $("div.navbar-collapse").addClass "collapse"
      topOffset = 100 # 2-row-menu
    else
      $("div.navbar-collapse").removeClass "collapse"
    height = (if (@window.innerHeight > 0) then @window.innerHeight else @screen.height)
    height = height - topOffset
    height = 1  if height < 1
    $("#page-wrapper").css "min-height", (height) + "px"  if height > topOffset
    return
  return
