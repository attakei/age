import std/unittest
import age/version
include age/engine

test "Initialized state of engine":
  let engine = newEngine(initVersion(1, 2, 3), initVersion(1, 2, 4))
  check(engine.rules.len == 0)
