(function() {

  describe("layOutDay", function() {
    var events;
    events = null;
    beforeEach(function() {
      return events = [
        {
          id: 1,
          start: 60,
          end: 120
        }, {
          id: 2,
          start: 100,
          end: 240
        }, {
          id: 3,
          start: 700,
          end: 720
        }
      ];
    });
    it("should be a function on window", function() {
      return expect(window.layOutDay).toBeDefined();
    });
    it("should return an array", function() {
      return expect(window.layOutDay([]) instanceof Array).toBeTruthy();
    });
    it("should return as many events as it was given", function() {
      return expect(window.layOutDay(events).length).toEqual(events.length);
    });
    return it("should return events with left and top set in addition to id, start, and end", function() {
      var event, _i, _j, _len, _len2, _ref, _ref2, _results;
      _ref = window.layOutDay(events);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        event = _ref[_i];
        expect(event.top).toBeDefined();
      }
      _ref2 = window.layOutDay(events);
      _results = [];
      for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
        event = _ref2[_j];
        _results.push(expect(event.left).toBeDefined());
      }
      return _results;
    });
  });

}).call(this);
