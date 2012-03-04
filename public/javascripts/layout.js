(function() {
  var CalendarEvent;

  CalendarEvent = (function() {

    function CalendarEvent(eventObject) {
      this.eventObject = eventObject;
      this.id = this.eventObject.id;
      this.start = this.eventObject.start;
      this.end = this.eventObject.end;
      this.top = this.start;
      this.collisions = [];
    }

    CalendarEvent.prototype.collidesWith = function(another) {
      var _ref, _ref2;
      if (another === this) return false;
      return ((this.start < (_ref = another.start) && _ref < this.end)) || ((this.start < (_ref2 = another.end) && _ref2 < this.end)) || (another.start < this.start && another.end > this.end);
    };

    CalendarEvent.prototype.startsBefore = function(another) {
      return this.start < another.start;
    };

    CalendarEvent.prototype.endsAfter = function(another) {
      return this.end > another.end;
    };

    return CalendarEvent;

  })();

  window.CalendarEvent = CalendarEvent;

  window.layOutDay = function(events) {
    var calendarEvents, event;
    calendarEvents = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = events.length; _i < _len; _i++) {
        event = events[_i];
        _results.push(new CalendarEvent(event));
      }
      return _results;
    })();
    return calendarEvents;
  };

  window.collisionsFor = function(calendarEvent, calendarEvents) {
    var collisions, otherEvent, _fn, _i, _len;
    collisions = [];
    _fn = function(calendarEvent, otherEvent, collisions) {
      if (calendarEvent.collidesWith(otherEvent)) collisions.push(otherEvent);
      return collisions;
    };
    for (_i = 0, _len = calendarEvents.length; _i < _len; _i++) {
      otherEvent = calendarEvents[_i];
      _fn(calendarEvent, otherEvent, collisions);
    }
    return collisions;
  };

}).call(this);
