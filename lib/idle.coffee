#Activity.js main class

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
      @isAway = false
      @setAwayTimeout(@awayTimeout)
      if(@onAwayBack)
        @onAwayBack()
  
  startAwayTimeout: () ->
    @awayTimestamp = new Date().getTime() + @awayTimeout
    if (@awayTimer != null) 
      clearInterval @awayTimer
    activity = this
    #added 100ms to the interval to allow setAway to trigger if called within that range  
    @awayTimer = setInterval (->
      activity.setAway()), @awayTimeout + 100
      
  setAwayTimeout: (ms) ->
    @awayTimeout = parseInt ms, 10
    @startAwayTimeout()
    
  setAway: () ->
    t = new Date().getTime()
    if (t < @awayTimestamp)
      @isAway = false
      #not away yet
      return
    
    #away now
    if (@awayTimer != null) 
      clearInterval @awayTimer 
    @isAway = true
    if(@onAway)
      @onAway()

window.Idle = Idle