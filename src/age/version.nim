## Version type definition
##
## This module defines ``Version`` types with fields and behaviors.
import std/strformat

type Version* = object
  ## Struct of version text.
  ##
  ## This fields are based on semantic versioning components,
  ## allowing it to retain both preceding and succeeding elements.
  major*: uint
  ## ``X`` of ``X.Y.Z``
  minor*: uint
  ## ``Y`` of ``X.Y.Z``
  patch*: uint
  ## ``Z`` of ``X.Y.Z``
  prefix*: string
  ## Prefix part of version text (e.g. ``"v`"`` of ``vX.Y.Z``)
  ## This part will used for "ver", "version" and any unit expression.
  suffix*: string

# Operators
# ---------

proc `$`*(v: Version): string =
  ## Express full text.
  result = fmt"{v.prefix}{v.major}.{v.minor}.{v.patch}{v.suffix}"

proc `==`*(a, b: Version): bool =
  (a.major, a.minor, a.patch, a.suffix) == (b.major, b.minor, b.patch, b.suffix)

proc `<`*(a, b: Version): bool =
  (a.major, a.minor, a.patch) < (b.major, b.minor, b.patch)

proc `<=`*(a, b: Version): bool =
  not (b < a)

# For other standard modules
# --------------------------

proc cmp*(a, b: Version): int =
  result = 0
  if a < b:
    result = -1
  elif a > b:
    result = 1

# Procs to return values by fields
# --------------------------------

proc `semver`*(v: Version): string =
  ## Express as semantic versioning.
  result = fmt"{v.major}.{v.minor}.{v.patch}"

# Factory procs
# -------------

proc initVersion*(
    major: uint = 0,
    minor: uint = 0,
    patch: uint = 0,
    prefix: string = "",
    suffix: string = "",
): Version =
  ## Create new ``Version`` object.
  result.major = major
  result.minor = minor
  result.patch = patch
  result.prefix = prefix
  result.suffix = suffix

proc incrementMajor*(
    version: Version, num: uint = 1, keepSuffix: bool = true
): Version =
  ## Creates a new Version object with its major version incremented based on the original Version object.
  result.major = version.major + num
  result.minor = 0
  result.patch = 0
  result.prefix = version.prefix
  if keepSuffix:
    result.suffix = version.suffix

proc incrementMinor*(
    version: Version, num: uint = 1, keepSuffix: bool = true
): Version =
  ## Creates a new Version object with its minor version incremented based on the original Version object.
  result.major = version.major
  result.minor = version.minor + num
  result.patch = 0
  result.prefix = version.prefix
  if keepSuffix:
    result.suffix = version.suffix

proc incrementPatch*(
    version: Version, num: uint = 1, keepSuffix: bool = true
): Version =
  ## Creates a new Version object with its patch version incremented based on the original Version object.
  result.major = version.major
  result.minor = version.minor
  result.patch = version.patch + num
  result.prefix = version.prefix
  if keepSuffix:
    result.suffix = version.suffix
