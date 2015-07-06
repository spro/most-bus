# most-bus
A pushable, pluggable stream for Most.js

# Usage

```coffee
bus = require 'most-bus'

# Create a bus
bus$ = bus()

# Create some streams to plug in
odd$ = most.from([1,3,5]).delay(50)
even$ = most.from([4,6,8]).delay(100)
hello$ = most.periodic(400, 'hello')

# Plug in the streams
bus$.plug odd$
bus$.plug even$
unplug_hello = bus$.plug hello$ # .plug returns an unplug function

# Push something directly onto the bus
bus$.push 'something'

# Unplug a stream
setTimeout unplug_hello, 900
```
