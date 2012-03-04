(function() {

  describe("layout problem", function() {
    var a, b, c, calendarEvents, d, deepEventList, e, events, f, g, nineToEleven, nineToElevenObject, tenToNoon, tenToNoonObject, thirteenToFifteen, thirteenToFifteenObject;
    a = b = c = d = e = f = g = deepEventList = null;
    events = null;
    calendarEvents = null;
    nineToElevenObject = null;
    tenToNoonObject = null;
    thirteenToFifteenObject = null;
    nineToEleven = null;
    tenToNoon = null;
    thirteenToFifteen = null;
    beforeEach(function() {
      nineToElevenObject = {
        id: 1,
        start: 60,
        end: 120
      };
      tenToNoonObject = {
        id: 2,
        start: 100,
        end: 240
      };
      thirteenToFifteenObject = {
        id: 3,
        start: 700,
        end: 720
      };
      events = [nineToElevenObject, tenToNoonObject, thirteenToFifteenObject];
      nineToEleven = new CalendarEvent(nineToElevenObject);
      tenToNoon = new CalendarEvent(tenToNoonObject);
      thirteenToFifteen = new CalendarEvent(thirteenToFifteenObject);
      calendarEvents = [tenToNoon, nineToEleven, thirteenToFifteen];
      a = new CalendarEvent({
        id: "a",
        start: 0,
        end: 120
      });
      b = new CalendarEvent({
        id: "b",
        start: 15,
        end: 135
      });
      c = new CalendarEvent({
        id: "c",
        start: 30,
        end: 270
      });
      d = new CalendarEvent({
        id: "d",
        start: 120,
        end: 240
      });
      e = new CalendarEvent({
        id: "e",
        start: 150,
        end: 250
      });
      f = new CalendarEvent({
        id: "f",
        start: 240,
        end: 360
      });
      g = new CalendarEvent({
        id: "g",
        start: 700,
        end: 720
      });
      return deepEventList = [e, a, b, f, d, c, g];
    });
    describe("CalendarEvent", function() {
      it("should exist", function() {
        return expect(CalendarEvent).toBeDefined();
      });
      it("should have a list of collisions", function() {
        expect(new CalendarEvent(nineToElevenObject).collisions).toBeDefined;
        return expect(new CalendarEvent(nineToElevenObject).collisions instanceof Array).toBeTruthy();
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
      it("should know when it collides with another calendar event", function() {
        expect(nineToEleven.collidesWith(tenToNoon)).toBeTruthy();
        expect(tenToNoon.collidesWith(nineToEleven)).toBeTruthy();
        expect(thirteenToFifteen.collidesWith(nineToEleven)).toBeFalsy();
        expect(thirteenToFifteen.collidesWith(tenToNoon)).toBeFalsy();
        expect(g.collidesWith(a)).toBeFalsy();
        expect(a.collidesWith(b)).toBeTruthy();
        expect(a.collidesWith(c)).toBeTruthy();
        expect(a.collidesWith(d)).toBeFalsy();
        expect(d.collidesWith(b)).toBeTruthy();
        expect(d.collidesWith(e)).toBeTruthy();
        expect(d.collidesWith(c)).toBeTruthy();
        expect(f.collidesWith(b)).toBeFalsy();
        expect(f.collidesWith(e)).toBeTruthy();
        return expect(f.collidesWith(c)).toBeTruthy();
      });
      it("should know when it starts before another event", function() {
        expect(nineToEleven.startsBefore(tenToNoon)).toBeTruthy();
        return expect(tenToNoon.startsBefore(nineToEleven)).toBeFalsy();
      });
      it("should know when it ends after another event", function() {
        expect(nineToEleven.endsAfter(tenToNoon)).toBeFalsy();
        return expect(tenToNoon.endsAfter(nineToEleven)).toBeTruthy();
      });
      return it("should not collide with itself", function() {
        return expect(nineToEleven.collidesWith(nineToEleven)).toBeFalsy();
      });
    });
    describe("layOutDay", function() {
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
      xit("should return events with width, left, and top set in addition to id, start, and end", function() {
        var event, _i, _j, _k, _l, _len, _len2, _len3, _len4, _ref, _ref2, _ref3, _ref4, _results;
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
        for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
          event = _ref3[_k];
          expect(event.left).toBeDefined();
        }
        _ref4 = layOutDay(events);
        _results = [];
        for (_l = 0, _len4 = _ref4.length; _l < _len4; _l++) {
          event = _ref4[_l];
          _results.push(expect(event.width).toBeDefined());
        }
        return _results;
      });
      xit("should set non-colliding event widths to 600", function() {
        var event, _i, _len, _ref, _results;
        _ref = layOutDay([thirteenToFifteenObject]);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          event = _ref[_i];
          _results.push(expect(event.width).toEqual(600));
        }
        return _results;
      });
      return xit("should set the widths of two colliding events to 300", function() {
        var event, _i, _len, _ref, _results;
        _ref = layOutDay([nineToEleven, tenToNoon]);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          event = _ref[_i];
          _results.push(expect(event.width).toEqual(300));
        }
        return _results;
      });
    });
    return describe("collisionsFor", function() {
      it("should be a function", function() {
        return expect(collisionsFor).toBeDefined();
      });
      it("should return an array", function() {
        return expect(collisionsFor(thirteenToFifteen, calendarEvents) instanceof Array).toBeTruthy();
      });
      it("should return an empty array if there are no collisions", function() {
        return expect(collisionsFor(thirteenToFifteen, calendarEvents).length).toEqual(0);
      });
      return it("should return all collisions if there are any", function() {
        return expect(collisionsFor(nineToEleven, calendarEvents).length).toEqual(1);
      });
    });
  });

}).call(this);
