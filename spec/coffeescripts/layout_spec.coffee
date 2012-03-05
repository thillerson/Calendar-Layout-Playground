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

    aObject = id : "a", start : 0,  end : 120
    bObject = id : "b", start : 15,  end : 135
    cObject = id : "c", start : 30,  end : 270
    dObject = id : "d", start : 120,  end : 240
    eObject = id : "e", start : 150,  end : 250
    fObject = id : "f", start : 240,  end : 360
    gObject = id : "g", start : 700,  end : 720
    a = new CalendarEvent(aObject)
    b = new CalendarEvent(bObject)
    c = new CalendarEvent(cObject)
    d = new CalendarEvent(dObject)
    e = new CalendarEvent(eObject)
    f = new CalendarEvent(fObject)
    g = new CalendarEvent(gObject)
    # randomizing the order for fun
    deepEventObjects = [ fObject, cObject, eObject, aObject, dObject, gObject, bObject ]
    deepEventList = [ e, a, b, f, d, c, g ]

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

  xdescribe "layOutDay", ->

    it "should be a function", ->
      expect( layOutDay ).toBeDefined()
      expect( layOutDay instanceof Function ).toBeTruthy()

    it "should return an array", ->
      expect( layOutDay([]) instanceof Array ).toBeTruthy()

    it "should return as many events as it was given", ->
      expect( layOutDay(events).length ).toEqual events.length

    xit "should set non-colliding event widths to 600", ->
      layout = layOutDay( [ thirteenToFifteenObject ] )
      expect(event.width).toEqual 600 for event in layout

    xit "should lay out the example problem set (with letters) as expected", ->
      layout = layOutDay deepEventList
      aEvent = _.find(layout, (item) -> item.id == "a")
      bEvent = _.find(layout, (item) -> item.id == "b")
      cEvent = _.find(layout, (item) -> item.id == "c")
      dEvent = _.find(layout, (item) -> item.id == "d")
      eEvent = _.find(layout, (item) -> item.id == "e")
      fEvent = _.find(layout, (item) -> item.id == "f")
      gEvent = _.find(layout, (item) -> item.id == "g")
      expect( aEvent.width ).toEqual 200
      expect( bEvent.width ).toEqual 200
      expect( cEvent.width ).toEqual 200
      expect( dEvent.width ).toEqual 200
      expect( eEvent.width ).toEqual 200
      expect( fEvent.width ).toEqual 200
      expect( gEvent.width ).toEqual 600
      expect( aEvent.left ).toEqual 0
      expect( bEvent.left ).toEqual 200
      expect( cEvent.left ).toEqual 400
      expect( dEvent.left ).toEqual 0
      expect( eEvent.left ).toEqual 200
      expect( fEvent.left ).toEqual 0
      expect( gEvent.left ).toEqual 0

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

      it "should size a list of one element as expected", ->
        sizeCollisionList [ nineToEleven ]
        expect( nineToEleven.left ).toEqual 0
        expect( nineToEleven.width ).toEqual 600

      it "should size a list of two elements as expected", ->
        sizeCollisionList [ nineToEleven, tenToNoon ]
        expect( nineToEleven.left ).toEqual 0
        expect( nineToEleven.width ).toEqual 300
        expect( tenToNoon.left ).toEqual 300
        expect( tenToNoon.width ).toEqual 300

    describe "widthForIndexInCollisionList", ->

      it "should be a function", ->
        expect( widthForIndexInCollisionList ).toBeDefined()

      it "should return 600 for a list with one element", ->
        expect( widthForIndexInCollisionList(0, [ nineToEleven ]) ).toEqual 600

      it "should return 300 for the first item in a list with two elements", ->
        expect( widthForIndexInCollisionList(0, [ nineToEleven, tenToNoon ]) ).toEqual 300

      it "should return 300 for the last item in a list with two elements", ->
        expect( widthForIndexInCollisionList(1, [ nineToEleven, tenToNoon ]) ).toEqual 300

    describe "leftPositionForIndexInCollisionList", ->

      it "should be a function", ->
        expect( leftPositionForIndexInCollisionList ).toBeDefined()

      it "should return 0 for a list with one element", ->
        expect( leftPositionForIndexInCollisionList(0, [ nineToEleven ]) ).toEqual 0

      it "should return 0 for the first item in a list with two elements", ->
        expect( leftPositionForIndexInCollisionList(0, [ nineToEleven, tenToNoon ]) ).toEqual 0

      it "should return 300 for the second item in a list with two elements", ->
        expect( leftPositionForIndexInCollisionList(1, [ nineToEleven, tenToNoon ]) ).toEqual 300

      it "should return expected values for a three item array", ->
        expect( leftPositionForIndexInCollisionList(0, [ a, b, c ]) ).toEqual 0
        expect( leftPositionForIndexInCollisionList(1, [ a, b, c ]) ).toEqual 200
        expect( leftPositionForIndexInCollisionList(2, [ a, b, c ]) ).toEqual 400

