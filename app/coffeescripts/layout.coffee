FULL_WIDTH = 600

class CalendarEvent

  constructor: (@eventObject) ->
    @id = @eventObject.id
    @start = @eventObject.start
    @end = @eventObject.end
    @top = @start
    @collisions = []

  collidesWith: (another) ->
    return false if another == @
    (@start < another.start < @end) or (@start < another.end < @end) or (another.start < @start and another.end > @end)

  startsBefore: (another) ->
    @start < another.start

  endsAfter: (another) ->
    @end > another.end

window.CalendarEvent = CalendarEvent

window.layOutDay = (events) ->
  calendarEvents = (new CalendarEvent(event) for event in events)
  calendarEvents

window.sizeCollisionList = (collisionList) ->
  sortedList = _.sortBy collisionList, (item) -> item.start
  for item, index in sortedList
    do (item, index, sortedList) ->

window.widthForIndexInCollisionList = (index, collisionList) ->
  width = ( FULL_WIDTH / collisionList.length )
  # The last element has to take up an extra pixel to balance out
  width = width - 1 if index == (index > 0 and collisionList.length - 1)
  width

window.collisionsFor = (calendarEvent, calendarEvents) ->
  collisions = []
  for otherEvent in calendarEvents
    do (calendarEvent, otherEvent, collisions) ->
      collisions.push otherEvent if calendarEvent.collidesWith otherEvent
      collisions

  collisions

