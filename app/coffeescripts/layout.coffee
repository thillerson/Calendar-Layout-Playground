class CalendarEvent

  constructor: (@eventObject) ->
    @id = @eventObject.id
    @start = @eventObject.start
    @end = @eventObject.end
    @top = @start
    @collisions = []

  collidesWith: (another) ->
    return false if another == @
    (@start <= another.start <= @end) or (@start <= another.end <= @end)

  startsBefore: (another) ->
    @start < another.start

  endsAfter: (another) ->
    @end > another.end

window.CalendarEvent = CalendarEvent

window.layOutDay = (events) ->
  calendarEvents = (new CalendarEvent(event) for event in events)
  eventMap = mappedEventListFor calendarEvents
  calendarEvents

# mappedEventListFor returns a hash where the keys
# should be all the left anchored calendar events
window.mappedEventListFor = (calendarEvents) ->
  eventMap = []
  for calendarEvent in calendarEvents
    do (calendarEvent, eventMap) ->
      collisions = collisionsFor calendarEvent, calendarEvents
      if ( collisions.length == 0 )
        calendarEvent.width = 600
        eventMap.push calendarEvent

  eventMap

window.collisionsFor = (calendarEvent, calendarEvents) ->
  collisions = []
  for otherEvent in calendarEvents
    do (calendarEvent, otherEvent, collisions) ->
      collisions.push otherEvent if calendarEvent.collidesWith otherEvent
      collisions

  collisions

