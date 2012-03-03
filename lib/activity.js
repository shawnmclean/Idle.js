(function() {
  var Activity;

  Activity = {};

  Activity = (function() {

    Activity.awayNow = false;

    Activity.awayTimeout = 3000;

    Activity.awayTimestamp = 0;

    Activity.awayTimer = null;

    Activity.onAway = null;

    Activity.onAwayBack = null;

    function Activity(options) {
      var activeMethod, activity;
      if (options) {
        this.awayTimeout = parseInt(options.awayTimeout, 10);
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
      this.startAwayTimeout();
    }

    Activity.prototype.onActive = function() {
      this.awayTimestamp = new Date().getTime() + this.awayTimeout;
      if (this.awayNow) {
        this.awayNow = false;
        this.setAwayTimeout(this.awayTimeout);
        if (this.onAwayBack) return this.onAwayBack();
      }
    };

    Activity.prototype.startAwayTimeout = function() {
      var activity;
      this.awayTimestamp = new Date().getTime() + this.awayTimeout;
      if (this.awayTimer !== null) clearInterval(this.awayTimer);
      activity = this;
      return this.awayTimer = setInterval((function() {
        return activity.setAway();
      }), this.awayTimeout);
    };

    Activity.prototype.setAwayTimeout = function(ms) {
      this.awayTimeout = parseInt(ms, 10);
      return this.startAwayTimeout();
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
      if (this.onAway) return this.onAway();
    };

    return Activity;

  })();

  window.Activity = Activity;

}).call(this);
