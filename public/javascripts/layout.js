(function() {
  var CalendarEvent;

  CalendarEvent = (function() {

    function CalendarEvent(eventObject) {
      this.eventObject = eventObject;
      this.id = this.eventObject.id;
      this.start = this.eventObject.start;
      this.end = this.eventObject.end;
    }

    return CalendarEvent;

  })();

  window.CalendarEvent = CalendarEvent;

  window.layOutDay = function(events) {
    var event, _i, _j, _len, _len2;
    for (_i = 0, _len = events.length; _i < _len; _i++) {
      event = events[_i];
      window.setTopFor(event);
    }
    for (_j = 0, _len2 = events.length; _j < _len2; _j++) {
      event = events[_j];
      window.setLeftFor(event);
    }
    return events;
  };

  window.setTopFor = function(event) {
    return event.top = event.start;
  };

  window.setLeftFor = function(event) {
    return event.left = 0;
  };

}).call(this);
