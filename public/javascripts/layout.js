(function() {
  var CalendarEvent, FULL_WIDTH;

  FULL_WIDTH = 600;

  CalendarEvent = (function() {

    function CalendarEvent(eventObject) {
      this.eventObject = eventObject;
      this.id = this.eventObject.id;
      this.start = this.eventObject.start;
      this.end = this.eventObject.end;
      this.top = this.start;
      this.left = 0;
      this.width = 0;
      this.column = 0;
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
    var calendarEvent, calendarEvents, event, eventsToProcess, _fn, _i, _len;
    calendarEvents = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = events.length; _i < _len; _i++) {
        event = events[_i];
        _results.push(new CalendarEvent(event));
      }
      return _results;
    })();
    eventsToProcess = _.sortBy(calendarEvents, function(event) {
      return event.start;
    });
    _fn = function(calendarEvent, eventsToProcess, calendarEvents) {
      var collisionList, event, index, processedEvent, _j, _len2, _len3, _results;
      collisionList = collisionsFor(calendarEvent, calendarEvents);
      for (index = 0, _len2 = collisionList.length; index < _len2; index++) {
        event = collisionList[index];
        if (!(event.column > 0)) event.column = index + 1;
      }
      sizeCollisionList(_.union(calendarEvent, collisionList));
      console.log("collisionList for " + calendarEvent.id, collisionList);
      _results = [];
      for (_j = 0, _len3 = collisionList.length; _j < _len3; _j++) {
        processedEvent = collisionList[_j];
        _results.push((function(processedEvent, collisionList) {
          index = _.indexOf(eventsToProcess, processedEvent);
          if (index !== -1) return eventsToProcess.splice(index, 1);
        })(processedEvent, collisionList));
      }
      return _results;
    };
    for (_i = 0, _len = eventsToProcess.length; _i < _len; _i++) {
      calendarEvent = eventsToProcess[_i];
      if (!calendarEvent) continue;
      _fn(calendarEvent, eventsToProcess, calendarEvents);
    }
    return calendarEvents;
  };

  window.sizeCollisionList = function(collisionList) {
    var columns, item, _i, _len, _results;
    columns = (_.max(collisionList, function(item) {
      return item.column;
    })).column;
    _results = [];
    for (_i = 0, _len = collisionList.length; _i < _len; _i++) {
      item = collisionList[_i];
      _results.push((function(item) {
        item.left = leftPositionForColumnGivenMaxColumn(item.column, columns);
        return item.width = widthForColumnGivenMaxColumn(columns);
      })(item));
    }
    return _results;
  };

  window.widthForColumnGivenMaxColumn = function(maxColumn) {
    return FULL_WIDTH / (maxColumn + 1);
  };

  window.leftPositionForColumnGivenMaxColumn = function(column, maxColumn) {
    return (FULL_WIDTH / (maxColumn + 1)) * column;
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
