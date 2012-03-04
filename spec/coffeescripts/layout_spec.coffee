describe "layout problem", ->

  a = b = c = d = e = f = g = deepEventList = null
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

    a = new CalendarEvent( id : "a", start : 0,  end : 120)
    b = new CalendarEvent( id : "b", start : 15,  end : 135)
    c = new CalendarEvent( id : "c", start : 30,  end : 270)
    d = new CalendarEvent( id : "d", start : 120,  end : 240)
    e = new CalendarEvent( id : "e", start : 150,  end : 250)
    f = new CalendarEvent( id : "f", start : 240,  end : 360)
    g = new CalendarEvent( id : "g", start : 700,  end : 720)
    # randomizing the order for fun
    deepEventList = [ e, a, b, f, d, c, g ]

  describe "CalendarEvent", ->

    it "should exist", ->
      expect(CalendarEvent).toBeDefined()

    it "should have a list of collisions", ->
      expect( new CalendarEvent( nineToElevenObject ).collisions ).toBeDefined
      expect( new CalendarEvent( nineToElevenObject ).collisions instanceof Array ).toBeTruthy()

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
      expect( g.collidesWith a ).toBeFalsy()
      expect( a.collidesWith b ).toBeTruthy()
      expect( a.collidesWith c ).toBeTruthy()
      expect( a.collidesWith d ).toBeFalsy()
      expect( d.collidesWith b ).toBeTruthy()
      expect( d.collidesWith e ).toBeTruthy()
      expect( d.collidesWith c ).toBeTruthy()
      expect( f.collidesWith b ).toBeFalsy()
      expect( f.collidesWith e ).toBeTruthy()
      expect( f.collidesWith c ).toBeTruthy()

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

    xit "should set non-colliding event widths to 600", ->
      expect(event.width).toEqual 600 for event in layOutDay( [ thirteenToFifteenObject ] )

    xit "should lay out the example problem set (with letters) as expected", ->
      layOutDay deepEventList
      expect( a.left ).toEqual 0
      expect( b.left ).toEqual 200
      expect( c.left ).toEqual 400
      expect( d.left ).toEqual 0
      expect( e.left ).toEqual 200
      expect( f.left ).toEqual 0
      expect( g.left ).toEqual 0

  describe "collisionsFor", ->

    it "should be a function", ->
      expect( collisionsFor ).toBeDefined()

    it "should return an array", ->
      expect( collisionsFor( thirteenToFifteen, calendarEvents ) instanceof Array ).toBeTruthy()

    it "should return an empty array if there are no collisions", ->
      expect( collisionsFor( thirteenToFifteen, calendarEvents ).length ).toEqual 0

    it "should return all collisions if there are any", ->
      expect( collisionsFor( nineToEleven, calendarEvents ).length ).toEqual 1

    describe "sizeCollisionList", ->

      it "should be a function", ->
        expect( sizeCollisionList ).toBeDefined()

      xit "should size a list of one element as expected", ->
        sizeCollisionList [ nineToEleven ]
        expect( nineToEleven.left ).toEqual 0
        expect( nineToEleven.width ).toEqual 600

      xit "should size a list of two elements as expected", ->
        sizeCollisionList [ nineToEleven, tenToNoon ]
        expect( nineToEleven.left ).toEqual 0
        expect( nineToEleven.width ).toEqual 199
        expect( tenToNoon.left ).toEqual 200
        expect( tenToNoon.width ).toEqual 199

    describe "widthForIndexInCollisionList", ->

      it "should be a function", ->
        expect( widthForIndexInCollisionList ).toBeDefined()

      it "should return 600 for a list with one element", ->
        expect( widthForIndexInCollisionList(0, [ nineToEleven ]) ).toEqual 600

      it "should return 300 for the first item in a list with two elements", ->
        expect( widthForIndexInCollisionList(0, [ nineToEleven, tenToNoon ]) ).toEqual 300

      it "should return 299 for the last item in a list with two elements", ->
        expect( widthForIndexInCollisionList(1, [ nineToEleven, tenToNoon ]) ).toEqual 299

