window.buildTimes = ->
  times = (buildTime(t)) for t in [ 0..720 ] by 30

window.buildTime = (mins) ->
  t = moment().hours( 9 ).minutes( 0 ).add( "minutes", mins )
  halfHour = (mins / 30) % 2 == 1
  prettyTime = t.format "h:mm"
  meridian = if (halfHour) then "" else t.format "A"
  labelTemplateId = if (halfHour) then "#halfHourLabelTemplate" else "#hourLabelTemplate"
  label = _.template($(labelTemplateId).html())( label : prettyTime, meridian : meridian )
  contents = _.template($("#halfHourContainerTemplate").html())( label : label, top : mins + 20 - 15)
  $("body").append contents
