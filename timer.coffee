module.exports = class Timer
  constructor: ->
    @startedAt = null
    @endedAt = null

  start: ->
    @startedAt = new Date().getTime()

  stop: ->
    @endedAt = new Date().getTime()

  @::__defineGetter__ 'length', ->
    @endedAt - @startedAt

  run: ->
    @start()
    complete = =>
      @stop()
      console.log @length + 'ms'

