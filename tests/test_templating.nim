include age/templating

import std/unittest

test "sameLengthCars":
  check(sameLengthChars("#", "Hello world") == "###########")
  check(sameLengthChars("=", "v0.1.0") == "======")
  check(sameLengthChars("^^", "v0.1.0") == "^^^^^^^^^^^^")

test "initContext":
  let now = initDateTime(4, mMar, 2012, 5, 6, 7)
  let ctx = initContext(now)
  ctx["version"] = "v0.1.0"
  let tmpl =
    """
{{version}}
{{#sameLengthChars}}=@{{version}}{{/sameLengthChars}}

{{nowFormat.dateISO}}
"""
  check(
    tmpl.render(ctx) ==
      """
v0.1.0
======

2012-03-04
"""
  )
