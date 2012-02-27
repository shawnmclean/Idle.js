(function() {

  window.Activity = (function() {

    Activity.awayNow = false;

    Activity.awayTimeout = 0;

    Activity.awayTimestamp = 0;

    Activity.awayTimer = null;

    Activity.onAway = null;

    Activity.onAwayBack = null;

    function Activity() {
      var activeMethod, activity;
      activity = this;
      activeMethod = function() {
        return activity.onActive();
      };
      window.onclick = activeMethod;
      window.onmousemove = activeMethod;
    }

    Activity.prototype.onActive = function() {
      this.awayTimestamp = 0;
      this.awayNow = false;
      if (this.awayNow) {
        try {
          if (this.onAwayBack) return activity.onAway();
        } catch (err) {

        }
      }
    };

    Activity.prototype.setAwayTimeout = function(ms) {
      var activity;
      this.awayTimeout = ms;
      this.awayTimestamp = new Date().getTime() + ms;
      if (this.awayTimer !== null) clearTimeout(this.awayTimer);
      activity = this;
      return this.awayTimer = setTimeout((function() {
        return activity.setAway(activity);
      }), ms + 50);
    };

    Activity.prototype.setAway = function(activity) {
      var t;
      t = new Date().getTime();
      if (t < activity.awayTimestamp) {
        activity.awayTimer = setTimeout(activity.setAway, ms - 50);
        return;
      }
      activity.awayNow = true;
      try {
        if (activity.onAway) return activity.onAway();
      } catch (err) {

      }
    };

    return Activity;

  })();

}).call(this);
