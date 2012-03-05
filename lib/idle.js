(function() {
  var Idle;

  Idle = {};

  Idle = (function() {

    Idle.isAway = false;

    Idle.awayTimeout = 3000;

    Idle.awayTimestamp = 0;

    Idle.awayTimer = null;

    Idle.onAway = null;

    Idle.onAwayBack = null;

    function Idle(options) {
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

    Idle.prototype.onActive = function() {
      this.awayTimestamp = new Date().getTime() + this.awayTimeout;
      if (this.isAway) {
        this.isAway = false;
        this.setAwayTimeout(this.awayTimeout);
        if (this.onAwayBack) return this.onAwayBack();
      }
    };

    Idle.prototype.startAwayTimeout = function() {
      var activity;
      this.awayTimestamp = new Date().getTime() + this.awayTimeout;
      if (this.awayTimer !== null) clearInterval(this.awayTimer);
      activity = this;
      return this.awayTimer = setInterval((function() {
        return activity.setAway();
      }), this.awayTimeout);
    };

    Idle.prototype.setAwayTimeout = function(ms) {
      this.awayTimeout = parseInt(ms, 10);
      return this.startAwayTimeout();
    };

    Idle.prototype.setAway = function() {
      var t;
      t = new Date().getTime();
      if (t < this.awayTimestamp) {
        this.isAway = false;
        return;
      }
      if (this.awayTimer !== null) clearInterval(this.awayTimer);
      this.isAway = true;
      if (this.onAway) return this.onAway();
    };

    return Idle;

  })();

  window.Idle = Idle;

}).call(this);
