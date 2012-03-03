describe "layout problem", ->
  describe "event", ->

    it "should exist", ->
      expect(CalendarEvent).toBeDefined()

    it "should accept an event object as defined in the puzzle instructions", ->
      calendarEvent = new CalendarEvent( id : 1, start : 60, end : 120 )
      expect(calendarEvent.id).toEqual 1
      expect(calendarEvent.start).toEqual 60
      expect(calendarEvent.end).toEqual 120

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



