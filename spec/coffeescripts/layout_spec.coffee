describe "layOutDay", ->

  it "should be a function on window", ->
    expect(window.layOutDay).toBeDefined()

  it "should return an array", ->
    expect(window.layOutDay([]) instanceof Array).toBeTruthy()
