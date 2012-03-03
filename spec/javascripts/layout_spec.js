(function() {

  describe("layOutDay", function() {
    it("should be a function on window", function() {
      return expect(window.layOutDay).toBeDefined();
    });
    return it("should return an array", function() {
      return expect(window.layOutDay([]) instanceof Array).toBeTruthy();
    });
  });

}).call(this);
