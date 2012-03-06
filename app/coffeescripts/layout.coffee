FULL_WIDTH = 600

class CalendarEvent

  constructor: (@eventObject) ->
    @id = @eventObject.id
    @start = @eventObject.start
    @end = @eventObject.end
    @top = @start
    @left = 0
    @width = 0
    @column = 0

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
  eventsToProcess = _.sortBy calendarEvents, (event) -> event.start
  for calendarEvent in eventsToProcess
    continue unless calendarEvent
    do (calendarEvent, eventsToProcess, calendarEvents) ->
      collisionList = ( collisionsFor calendarEvent, calendarEvents)
      (event.column = index + 1 unless event.column > 0) for event, index in collisionList
      sizeCollisionList _.union calendarEvent, collisionList
      console.log "collisionList for #{calendarEvent.id}", collisionList
      for processedEvent in collisionList
        do (processedEvent, collisionList) ->
          index = _.indexOf eventsToProcess, processedEvent
          eventsToProcess.splice(index, 1) if index != -1
  calendarEvents

window.sizeCollisionList = (collisionList) ->
  columns = (_.max collisionList, (item) -> item.column).column
  for item in collisionList
    do (item) ->
      item.left = leftPositionForColumnGivenMaxColumn item.column, columns
      item.width = widthForColumnGivenMaxColumn columns

window.widthForColumnGivenMaxColumn = (maxColumn) ->
  FULL_WIDTH / (maxColumn + 1)

window.leftPositionForColumnGivenMaxColumn = (column, maxColumn) ->
  ( FULL_WIDTH / (maxColumn + 1) ) * column

window.collisionsFor = (calendarEvent, calendarEvents) ->
  collisions = []
  for otherEvent in calendarEvents
    do (calendarEvent, otherEvent, collisions) ->
      collisions.push otherEvent if calendarEvent.collidesWith otherEvent
      collisions

  collisions
