class window.Activity
  @awayNow: false
  @awayTimeout: 0
  @awayTimestamp: 0
  @awayTimer: null
  
  @onAway: null
  @onAwayBack: null
  
  constructor: () ->
    activity = this
    activeMethod = () ->
      activity.onActive()
    window.onclick = activeMethod
    window.onmousemove = activeMethod
  
  onActive: () ->
    @awayTimestamp = 0
    @awayNow = false
    if(@awayNow)
      try
        if(@onAwayBack)
          activity.onAway()
      catch err
      
  setAwayTimeout: (ms) ->
    @awayTimeout = ms
    @awayTimestamp = new Date().getTime() + ms
    if (@awayTimer != null) 
      clearTimeout @awayTimer
    activity = this
    @awayTimer = setTimeout (->
      activity.setAway(activity)), ms + 50
    
    
  setAway: (activity) ->
    t = new Date().getTime()
    if (t < activity.awayTimestamp)
      #not away yet
      activity.awayTimer = setTimeout(activity.setAway, ms - 50)
      return
    
    #away now    
    activity.awayNow = true    
    try
      if(activity.onAway)
        activity.onAway()
    catch err
    