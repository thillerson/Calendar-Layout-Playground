describe "layout problem", ->

  events                   = null
  calendarEvents           = null
  nineToElevenObject       = null
  tenToNoonObject          = null
  thirteenToFifteenObject  = null
  nineToEleven             = null
  tenToNoon                = null
  thirteenToFifteen        = null

  beforeEach ->
    nineToElevenObject       = id : 1, start : 60, end : 120
    tenToNoonObject          = id : 2, start : 100, end : 240
    thirteenToFifteenObject  = id : 3, start : 700, end : 720

    events = [
      nineToElevenObject
      tenToNoonObject
      thirteenToFifteenObject
    ]

    nineToEleven             = new CalendarEvent( nineToElevenObject )
    tenToNoon                = new CalendarEvent( tenToNoonObject )
    thirteenToFifteen        = new CalendarEvent( thirteenToFifteenObject )

    calendarEvents = [
      tenToNoon
      nineToEleven
      thirteenToFifteen
    ]

  describe "CalendarEvent", ->

    it "should exist", ->
      expect(CalendarEvent).toBeDefined()

    it "should accept an event object as defined in the puzzle instructions", ->
      calendarEvent = new CalendarEvent( id : 1, start : 60, end : 120 )
      expect(calendarEvent.id).toEqual 1
      expect(calendarEvent.start).toEqual 60
      expect(calendarEvent.end).toEqual 120

    it "should know when it collides with another calendar event", ->
      expect( nineToEleven.collidesWith tenToNoon ).toBeTruthy()
      expect( tenToNoon.collidesWith nineToEleven ).toBeTruthy()
      expect( thirteenToFifteen.collidesWith nineToEleven ).toBeFalsy()
      expect( thirteenToFifteen.collidesWith tenToNoon ).toBeFalsy()

    it "should know when it starts before another event", ->
      expect( nineToEleven.startsBefore tenToNoon ).toBeTruthy()
      expect( tenToNoon.startsBefore nineToEleven ).toBeFalsy()

    it "should know when it ends after another event", ->
      expect( nineToEleven.endsAfter tenToNoon ).toBeFalsy()
      expect( tenToNoon.endsAfter nineToEleven ).toBeTruthy()

    it "should not collide with itself", ->
      expect( nineToEleven.collidesWith nineToEleven ).toBeFalsy()

  describe "layOutDay", ->

    it "should be a function", ->
      expect( layOutDay ).toBeDefined()
      expect( layOutDay instanceof Function ).toBeTruthy()

    it "should return an array", ->
      expect( layOutDay([]) instanceof Array ).toBeTruthy()

    it "should return as many events as it was given", ->
      expect( layOutDay(events).length ).toEqual events.length

    xit "should return events with width, left, and top set in addition to id, start, and end", ->
      expect(event.top).toBeDefined() for event in layOutDay(events)
      expect(event.top).toEqual(event.start) for event in layOutDay(events)
      expect(event.left).toBeDefined() for event in layOutDay(events)
      expect(event.width).toBeDefined() for event in layOutDay(events)

    it "should set non-colliding event widths to 600", ->
      expect(event.width).toEqual 600 for event in layOutDay( [ thirteenToFifteenObject ] )

    xit "should set the widths of two colliding events to 300", ->
      expect(event.width).toEqual 300 for event in layOutDay( [ nineToEleven, tenToNoon ] )

  describe "eventMapFor", ->


  describe "collisionsFor", ->

    it "should be a function", ->
      expect( collisionsFor ).toBeDefined()

    it "should return an array", ->
      expect( collisionsFor( thirteenToFifteen, calendarEvents ) instanceof Array ).toBeTruthy()

    it "should return an empty array if there are no collisions", ->
      expect( collisionsFor( thirteenToFifteen, calendarEvents ).length ).toEqual 0

    it "should return all collisions if there are any", ->
      expect( collisionsFor( nineToEleven, calendarEvents ).length ).toEqual 1
