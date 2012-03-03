describe "layOutDay", ->

  events = null

  beforeEach ->
    events = [
      { id : 1, start : 60, end : 120 }
      { id : 2, start : 100, end : 240 }
      { id : 3, start : 700, end : 720 }
    ]

  it "should be a function on window", ->
    expect( window.layOutDay ).toBeDefined()

  it "should return an array", ->
    expect( window.layOutDay([]) instanceof Array ).toBeTruthy()

  it "should return as many events as it was given", ->
    expect( window.layOutDay(events).length ).toEqual events.length