(function() {
  var Activity;

  Activity = {};

  Activity = (function() {

    Activity.awayNow = false;

    Activity.awayTimeout = 0;

    Activity.awayTimestamp = 0;

    Activity.awayTimer = null;

    Activity.onAway = null;

    Activity.onAwayBack = null;

    function Activity(options) {
      var activeMethod, activity;
      if (options) {
        this.awayTimeout = options.awayTimeout;
        this.onAway = options.onAway;
        this.onAwayBack = options.onAwayBack;
      }
      activity = this;
      activeMethod = function() {
        return activity.onActive();
      };
      window.onclick = activeMethod;
      window.onmousemove = activeMethod;
      window.onmouseenter = activeMethod;
      window.onkeydown = activeMethod;
      window.onscroll = activeMethod;
      this.setAwayTimeout(3000);
    }

    Activity.prototype.onActive = function() {
      this.awayTimestamp = new Date().getTime() + this.awayTimeout;
      if (this.awayNow) {
        this.awayNow = false;
        try {
          this.setAwayTimeout(this.awayTimeout);
          if (this.onAwayBack) return this.onAwayBack();
        } catch (err) {

        }
      }
    };

    Activity.prototype.setAwayTimeout = function(ms) {
      var activity;
      this.awayTimeout = ms;
      this.awayTimestamp = new Date().getTime() + ms;
      if (this.awayTimer !== null) clearInterval(this.awayTimer);
      activity = this;
      return this.awayTimer = setInterval((function() {
        return activity.setAway();
      }), ms + 50);
    };

    Activity.prototype.setAway = function() {
      var t;
      t = new Date().getTime();
      if (t < this.awayTimestamp) {
        this.awayNow = false;
        return;
      }
      if (this.awayTimer !== null) clearInterval(this.awayTimer);
      this.awayNow = true;
      try {
        if (this.onAway) return this.onAway();
      } catch (err) {

      }
    };

    return Activity;

  })();

  window.Activity = Activity;

}).call(this);
