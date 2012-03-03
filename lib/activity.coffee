#Activity.js main class

Activity = { }
class Activity
  @awayNow: false
  @awayTimeout: 0
  @awayTimestamp: 0
  @awayTimer: null
  
  @onAway: null
  @onAwayBack: null
  
  #Initialize the class
  #
  # @param (Object) options
  constructor: (options) ->
    if(options)
      @awayTimeout = options.awayTimeout
      @onAway = options.onAway
      @onAwayBack = options.onAwayBack
    
    #object to be accessed in the events that will be called by window.
    activity = this
    activeMethod = () ->
      activity.onActive()
    #the methods that we will use to know when there is some activity on the page
    window.onclick = activeMethod
    window.onmousemove = activeMethod
    window.onmouseenter = activeMethod
    window.onkeydown = activeMethod
    window.onscroll = activeMethod
    
    #start up the timer for away with default 3 seconds
    @setAwayTimeout(3000)
  
  onActive: () ->
    @awayTimestamp = new Date().getTime() + @awayTimeout
    if(@awayNow)
      @awayNow = false
      try
        @setAwayTimeout(@awayTimeout)
        if(@onAwayBack)
          @onAwayBack()
      catch err
      
  setAwayTimeout: (ms) ->
    @awayTimeout = ms
    @awayTimestamp = new Date().getTime() + ms
    if (@awayTimer != null) 
      clearInterval @awayTimer
    activity = this
    @awayTimer = setInterval (->
      activity.setAway()), ms
    
    
  setAway: () ->
    t = new Date().getTime()
    if (t < @awayTimestamp)
      @awayNow = false
      #not away yet
      #console.log('Not away yet. Away in ' + (@awayTimestamp - t));
      return
    
    #away now
    if (@awayTimer != null) 
      clearInterval @awayTimer 
    @awayNow = true    
    try
      if(@onAway)
        @onAway()
    catch err

window.Activity = Activity