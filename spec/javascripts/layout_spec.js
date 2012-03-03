(function() {

  describe("layout problem", function() {
    describe("CalendarEvent", function() {
      var nineToEleven, tenToNoon, thirteenToFifteen;
      nineToEleven = null;
      tenToNoon = null;
      thirteenToFifteen = null;
      beforeEach(function() {
        nineToEleven = new CalendarEvent({
          id: 1,
          start: 0,
          end: 120
        });
        tenToNoon = new CalendarEvent({
          id: 2,
          start: 60,
          end: 180
        });
        return thirteenToFifteen = new CalendarEvent({
          id: 2,
          start: 240,
          end: 360
        });
      });
      it("should exist", function() {
        return expect(CalendarEvent).toBeDefined();
      });
      it("should accept an event object as defined in the puzzle instructions", function() {
        var calendarEvent;
        calendarEvent = new CalendarEvent({
          id: 1,
          start: 60,
          end: 120
        });
        expect(calendarEvent.id).toEqual(1);
        expect(calendarEvent.start).toEqual(60);
        return expect(calendarEvent.end).toEqual(120);
      });
      return it("should know when it collides with another calendar event", function() {
        expect(nineToEleven.collidesWith(tenToNoon)).toBeTruthy();
        expect(tenToNoon.collidesWith(nineToEleven)).toBeTruthy();
        expect(thirteenToFifteen.collidesWith(nineToEleven)).toBeFalsy();
        return expect(thirteenToFifteen.collidesWith(tenToNoon)).toBeFalsy();
      });
    });
    return describe("layOutDay", function() {
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
      it("should be a function", function() {
        expect(layOutDay).toBeDefined();
        return expect(layOutDay instanceof Function).toBeTruthy();
      });
      it("should return an array", function() {
        return expect(layOutDay([]) instanceof Array).toBeTruthy();
      });
      it("should return as many events as it was given", function() {
        return expect(layOutDay(events).length).toEqual(events.length);
      });
      return it("should return events with left and top set in addition to id, start, and end", function() {
        var event, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3, _results;
        _ref = layOutDay(events);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          event = _ref[_i];
          expect(event.top).toBeDefined();
        }
        _ref2 = layOutDay(events);
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          event = _ref2[_j];
          expect(event.top).toEqual(event.start);
        }
        _ref3 = layOutDay(events);
        _results = [];
        for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
          event = _ref3[_k];
          _results.push(expect(event.left).toBeDefined());
        }
        return _results;
      });
    });
  });

}).call(this);
