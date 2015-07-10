most = require 'most'

if !setImmediate?
    setImmediate = (f) -> setTimeout f, 0

bus = (initial) ->
    _add = _end = _error = null
    b$ = most.create (add, end, error) ->
        _add = add; _end = end; _error = error
    b$.push = (v) ->
        setImmediate -> _add? v
    b$.end = ->
        setImmediate -> _end?()
    b$.error = (e) ->
        setImmediate -> _error? e
    b$.plug = (v$) ->
        w$ = bus() # Endable wrapper
        v$.forEach w$.push # Forward values to wrapper
        w$.forEach b$.push # Forward wrapper to bus
        return w$.end
    if initial? then b$.push initial
    return b$

module.exports = bus

