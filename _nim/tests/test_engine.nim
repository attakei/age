import std/unittest
import semver
include age/engine

test "Initialized state of engine":
  let engine = newEngine(newVersion(1, 2, 3), newVersion(1, 2, 4))
  check(engine.rules.len == 0)
