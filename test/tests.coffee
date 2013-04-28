module "Idle.js", {}

asyncTest "onAway executed after specified timeframe", ->
  expect 1
  awayTimeout = 2000
  startTime = new Date().getTime()
  idle = new Idle(
    awayTimeout: awayTimeout
    onAway: ()->
      timeTaken = new Date().getTime()- startTime
      ok parseInt(timeTaken/1000) == parseInt(awayTimeout/1000), "onAway was not executed in specified timeframe (+-) 500ms"
      start()
  ).start()
