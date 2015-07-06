most = require 'most'
bus = require 'most-bus'
R = require 'ramda'

# Logging helper
log = (t) -> (v) -> console.log t, v

# Create a bus
bus$ = bus()
bus$.forEach(log 'bus$ ->')

# Create some streams to plug in
odd$ = most.from([1,3,5]).delay(50)
even$ = most.from([4,6,8]).delay(100)
hello$ = most.periodic(400, 'hello')

# Plug in the streams
bus$.plug odd$
bus$.plug even$
unplug_hello = bus$.plug hello$ # .plug returns an unplug function

# Unplug one
setTimeout unplug_hello, 900

# Push something directly onto the bus
setTimeout (-> bus$.push 'something'), 500

# Show the bus is otherwise a regular stream
bus$.filter(isFinite).forEach(log 'n =')

# Expected output
#
# odd$     |--135X
# even$    |------468X
# hello$   |h---------h---------h----> Unplugged, but continues
#
# bus$     |h-135-468-h-s-------h-->
# .push                 ^

