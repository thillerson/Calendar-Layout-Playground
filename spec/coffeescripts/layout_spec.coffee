describe "layout problem", ->

  describe "CalendarEvent", ->

    nineToEleven       = null
    tenToNoon          = null
    thirteenToFifteen  = null

    beforeEach ->
      nineToEleven          = new CalendarEvent( id : 1, start : 0, end : 120 )
      tenToNoon             = new CalendarEvent( id : 2, start : 60, end : 180 )
      thirteenToFifteen     = new CalendarEvent( id : 2, start : 240, end : 360 )

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

  describe "layOutDay", ->

    events = null

    beforeEach ->
      events = [
        { id : 1, start : 60, end : 120 }
        { id : 2, start : 100, end : 240 }
        { id : 3, start : 700, end : 720 }
      ]

    it "should be a function", ->
      expect( layOutDay ).toBeDefined()
      expect( layOutDay instanceof Function ).toBeTruthy()

    it "should return an array", ->
      expect( layOutDay([]) instanceof Array ).toBeTruthy()

    it "should return as many events as it was given", ->
      expect( layOutDay(events).length ).toEqual events.length

    it "should return events with left and top set in addition to id, start, and end", ->
      expect(event.top).toBeDefined() for event in layOutDay(events)
      expect(event.top).toEqual(event.start) for event in layOutDay(events)
      expect(event.left).toBeDefined() for event in layOutDay(events)



