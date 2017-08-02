(function() {
  module("Idle.js", {});

  asyncTest("onAway executed after specified timeframe", function() {
    var awayTimeout, idle, startTime;

    expect(1);
    awayTimeout = 2000;
    startTime = new Date().getTime();
    return idle = new Idle({
      awayTimeout: awayTimeout,
      onAway: function() {
        var timeTaken;

        timeTaken = new Date().getTime() - startTime;
        ok(parseInt(timeTaken / 1000) === parseInt(awayTimeout / 1000), "onAway was not executed in specified timeframe (+-) 500ms");
        return start();
      }
    }).start();
  });

}).call(this);
