##[Templating bridge.

This module has helper functions to render content of age.
]##
import std/[strutils, tables, times]

import mustache

# Cast overloads

proc castValue(value: DateTime): Value =
  return Value(kind: vkString, vString: $value)

# Lambdas

proc sameLengthChars(chr: char, base: string): string =
  ##[Retrieve strings repeated char as same length as base string.
  ]##
  return chr.repeat(len(base))

# Operation for context

proc setCurrentDateTime(ctx: Context, dt: DateTime) =
  ##[Add currentTime of running context.

  With adding, bind some formatted values of datetime.
  ]##
  ctx["now"] = dt
  ctx["nowFormat"] = {"dateISO": format(dt, "yyyy-MM-dd")}.toTable

# Creation context

proc initContext*(dt: DateTime): Context =
  result = newContext()
  result.setCurrentDateTime(dt)
  result["sameLengthChars"] = proc(s: string, c: Context): string =
    let
      chr = s[0]
      base = s.render(c)[1 ..^ 1]
    return sameLengthChars(chr, base)
