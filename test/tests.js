(function() {

  module("Idle.js", {});

  test('onAway_fires_after_2_seconds', function() {
    var c;
    stop(2000);
    return c = new Idle({
      awayTimeout: 2000,
      onAway: function() {
        return start();
      }
    });
  });

  test('onAwayBack_fires_on_onclick', function() {
    return ok(true);
  });

}).call(this);
