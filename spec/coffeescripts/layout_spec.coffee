describe "layOutDay", ->

  events = null

  beforeEach ->
    events = [
      { id : 1, start : 60, end : 120 }
      { id : 2, start : 100, end : 240 }
      { id : 3, start : 700, end : 720 }
    ]

  describe "detectCollisions", ->

    it "should be a function", ->
      expect( detectCollisions ).toBeDefined()
      expect( detectCollisions instanceof Function ).toBeTruthy()

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


