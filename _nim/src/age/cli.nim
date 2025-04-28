##[CLI subcommand works.
]##
import std/[logging, tables]
import semver
import ./[config, engine, versioning]

proc info*(): int =
  ## Display config.
  result = 0

proc update*(args: seq[string]): int =
  ## Update target specified version.
  debug("Call 'update' command.")
  result = 1
  let conf = autoConfig()
  let nextVersion = parseVersion(args[0])
  let engine = newEngine(conf, nextVersion)
  result = engine.run()

proc major*(): int =
  ## Update target for "major" level updated version.
  debug("Call 'major' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf, conf.currentVersion.newMajorVersion)
  result = engine.run()

proc minor*(): int =
  ## Update target for "minor" level updated version.
  debug("Call 'minor' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf, conf.currentVersion.newMinorVersion)
  result = engine.run()

proc patch*(): int =
  ## Update target for "patch" level updated version.
  debug("Call 'patch' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf, conf.currentVersion.newPatchVersion)
  echo len(engine.rules)
  result = engine.run()

proc init*(): int =
  ## Create configuration file.
  result = 0

proc help*(): int =
  ## Print help message.
  result = 0
