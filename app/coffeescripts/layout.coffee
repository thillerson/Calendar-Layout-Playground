class CalendarEvent

  constructor: (@eventObject) ->
    @id = @eventObject.id
    @start = @eventObject.start
    @end = @eventObject.end

window.CalendarEvent = CalendarEvent

window.layOutDay = (events) ->
  window.setTopFor event for event in events
  window.setLeftFor event for event in events
  events

window.setTopFor = (event) ->
  event.top = event.start

window.setLeftFor = (event) ->
  event.left = 0
