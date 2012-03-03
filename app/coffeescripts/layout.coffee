class CalendarEvent

  constructor: (@eventObject) ->
    @id = @eventObject.id
    @start = @eventObject.start
    @end = @eventObject.end

  collidesWith: (another) ->
    (@start <= another.start <= @end) or (@start <= another.end <= @end)

  startsBefore: (another) ->
    @start < another.start

  endsAfter: (another) ->
    @end > another.end

window.CalendarEvent = CalendarEvent

window.layOutDay = (events) ->
  window.setTopFor event for event in events
  window.setLeftFor event for event in events
  events

window.setTopFor = (event) ->
  event.top = event.start

window.setLeftFor = (event) ->
  event.left = 0
