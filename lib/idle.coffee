#Idle.js main class

Idle = { }
class Idle
  @isAway: false
  #set default timeout to 3 seconds
  @awayTimeout: 3000
  @awayTimestamp: 0
  @awayTimer: null
  
  @onAway: null
  @onAwayBack: null
  
  #Initialize the class
  #
  # @param (Object) options
  constructor: (options) ->
    if(options)
      @awayTimeout = parseInt options.awayTimeout, 10
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
    
    @startAwayTimeout()
  
  onActive: () ->    
    @awayTimestamp = new Date().getTime() + @awayTimeout
    if(@isAway)
      #trigger callback for the user coming back from being away
      if(@onAwayBack)
        @onAwayBack()
      #reset the away timeout.
      @startAwayTimeout()
    #ensure that the state is not away        
    @isAway = false
    #return true for the event.
    return true
  
  startAwayTimeout: () ->
    @awayTimestamp = new Date().getTime() + @awayTimeout
    if (@awayTimer != null) 
      clearTimeout @awayTimer
    activity = this 
    #give the timer a 100ms delay
    @awayTimer = setTimeout (->
      activity.setAway()), @awayTimeout + 100
      
  setAwayTimeout: (ms) ->
    @awayTimeout = parseInt ms, 10
    @startAwayTimeout()
    
  setAway: () ->
    t = new Date().getTime()
    if (t < @awayTimestamp)
      @isAway = false
      #not away yet, reset the timer with current awaytimestamp - current time with the 100ms delay
      activity = this 
      @awayTimer = setTimeout (->
        activity.setAway()), @awayTimestamp - t + 100
      return
    
    #away now
    if (@awayTimer != null) 
      clearTimeout @awayTimer 
    @isAway = true
    if(@onAway)
      @onAway()

window.Idle = Idle