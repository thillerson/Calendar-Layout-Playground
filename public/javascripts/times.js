(function() {

  window.buildTimes = function() {
    var t, times, _results;
    _results = [];
    for (t = 0; t <= 720; t += 30) {
      _results.push(times = buildTime(t));
    }
    return _results;
  };

  window.buildTime = function(mins) {
    var contents, halfHour, label, labelTemplateId, meridian, prettyTime, t;
    t = moment().hours(9).minutes(0).add("minutes", mins);
    halfHour = (mins / 30) % 2 === 1;
    prettyTime = t.format("h:mm");
    meridian = halfHour ? "" : t.format("A");
    labelTemplateId = halfHour ? "#halfHourLabelTemplate" : "#hourLabelTemplate";
    label = _.template($(labelTemplateId).html())({
      label: prettyTime,
      meridian: meridian
    });
    contents = _.template($("#halfHourContainerTemplate").html())({
      label: label,
      top: mins + 20 - 15
    });
    return $("body").append(contents);
  };

}).call(this);
