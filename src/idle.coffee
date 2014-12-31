# IE8* fillers for document.addEventListener & removeEventListener
if (!document.addEventListener)  # W3C DOM
  if (document.attachEvent) # IE DOM
    document.addEventListener = (event, callback, useCapture) ->
      document.attachEvent("on" + event, callback, useCapture)
  else # No-op to prevent error
    document.addEventListener = () ->
      {}
if (!document.removeEventListener)  # W3C DOM
  if (document.detachEvent) # IE DOM
    document.removeEventListener = (event, callback) ->
      document.detachEvent("on" + event, callback)
  else # No-op to prevent error
    document.removeEventListener = () ->
      {}


#Idle.js main class
"use strict"
Idle = { }
class Idle
  @isAway: false
  #set default timeout to 3 seconds
  @awayTimeout: 3000
  @awayTimestamp: 0
  @awayTimer: null

  #events for monitoring user activity on the page
  @onAway: null
  @onAwayBack: null

  #events for the visibility API
  @onVisible: null
  @onHidden: null

  #Initialize the class
  #
  # @param (Object) options
  constructor: (options) ->
    if(options)
      @awayTimeout = parseInt options.awayTimeout, 10
      @onAway = options.onAway
      @onAwayBack = options.onAwayBack
      @onVisible = options.onVisible
      @onHidden = options.onHidden

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
    window.onmousewheel = activeMethod

  onActive: () ->
    @awayTimestamp = new Date().getTime() + @awayTimeout
    if(@isAway)
      #trigger callback for the user coming back from being away
      if(@onAwayBack)
        @onAwayBack()
      #reset the away timeout.
      @start()
    #ensure that the state is not away
    @isAway = false
    #return true for the event.
    return true

  start: () ->

    #setup events for page visibility api
    if (!@listener)   # only once even if start was called multiple times without stop
      @listener = (-> activity.handleVisibilityChange())
      if (typeof document.hidden != 'undefined')
        @changeEvent = 'visibilitychange'
      else if (document.mozHidden != 'undefined')
        @changeEvent = 'mozvisibilitychange'
      else if (document.webkitHidden != 'undefined')
        @changeEvent = 'webkitvisibilitychange'
      else if (document.msHidden != 'undefined')
        @changeEvent = 'msvisibilitychange'
      document.addEventListener @changeEvent, @listener, false if @changeEvent?

    @awayTimestamp = new Date().getTime() + @awayTimeout
    if (@awayTimer != null)
      clearTimeout @awayTimer
    activity = this
    #give the timer a 100ms delay
    @awayTimer = setTimeout (->
      activity.checkAway()), @awayTimeout + 100
    @

  stop: () ->
    if (@awayTimer != null)
      clearTimeout @awayTimer
    if (@listener != null && @changeEvent)
      document.removeEventListener @changeEvent, @listener
      @listener = null
    @

  setAwayTimeout: (ms) ->
    @awayTimeout = parseInt ms, 10
    @

  checkAway: () ->
    t = new Date().getTime()
    if (t < @awayTimestamp)
      @isAway = false
      #not away yet, reset the timer with current awaytimestamp - current time with the 100ms delay
      activity = this
      @awayTimer = setTimeout (->
        activity.checkAway()), @awayTimestamp - t + 100
      return

    #away now
    if (@awayTimer != null)
      clearTimeout @awayTimer
    @isAway = true
    if(@onAway)
      @onAway()

  handleVisibilityChange: () ->
    #check for hidden for various browsers
    if(document.hidden || document.mozHidden || document.msHidden || document.webkitHidden)
      if(@onHidden)
        @onHidden()
    else
      if(@onVisible)
        @onVisible()
window.Idle = Idle
