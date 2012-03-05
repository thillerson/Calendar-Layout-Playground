FULL_WIDTH = 600

class CalendarEvent

  constructor: (@eventObject) ->
    @id = @eventObject.id
    @start = @eventObject.start
    @end = @eventObject.end
    @top = @start
    @left = 0
    @width = 0

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
  for calendarEvent in calendarEvents
    do (calendarEvent, calendarEvents) ->
      collisionList = ( collisionsFor calendarEvent, calendarEvents )
      normalizedList = normalizedCollisionList( _.union(calendarEvent, collisionList) )
      # OMG - Side effects!
      sizeCollisionList normalizedList
  calendarEvents

window.sizeCollisionList = (collisionList) ->
  sortedList = _.sortBy collisionList, (item) -> item.start
  for item, index in sortedList
    do (item, index, sortedList) ->
      item.left = leftPositionForIndexInCollisionList index, sortedList
      item.width = widthForIndexInCollisionList index, sortedList

window.widthForIndexInCollisionList = (index, collisionList) ->
  FULL_WIDTH / collisionList.length

window.leftPositionForIndexInCollisionList = (index, collisionList) ->
  ( FULL_WIDTH / collisionList.length ) * index

window.collisionsFor = (calendarEvent, calendarEvents) ->
  collisions = []
  for otherEvent in calendarEvents
    do (calendarEvent, otherEvent, collisions) ->
      collisions.push otherEvent if calendarEvent.collidesWith otherEvent
      collisions

  collisions

