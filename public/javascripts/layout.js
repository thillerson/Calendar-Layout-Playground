(function() {

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

  window.detectCollisions = function(events) {
    return [];
  };

}).call(this);
