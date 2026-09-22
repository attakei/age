##[CLI subcommand works.
]##
import std/[paths, sequtils, tables]
import chronicles
import semver
import ./[config, engine, info, init, versioning]

proc info*(): int =
  ## Display config.
  debug "Start command", command = "info"
  result = 1
  let conf = autoConfig()
  let workspace = newWorkspace(conf[0], conf[1], conf[2])
  result = workspace.displayInfo()

proc update*(args: seq[string]): int =
  ## Update target specified version.
  debug "Start command", command = "update"
  result = 1
  let conf = autoConfig()
  let nextVersion = parseVersion(args[0])
  let engine = newEngine(conf[0], nextVersion)
  result = engine.run()

proc major*(): int =
  ## Update target for "major" level updated version.
  debug "Start command", command = "major"
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.newMajorVersion)
  result = engine.run()

proc minor*(): int =
  ## Update target for "minor" level updated version.
  debug "Start command", command = "minor"
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.newMinorVersion)
  result = engine.run()

proc patch*(): int =
  ## Update target for "patch" level updated version.
  debug "Start command", command = "patch"
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.newPatchVersion)
  result = engine.run()

proc init*(preset: seq[string] = @[], args: seq[string]): int =
  ## Create configuration file.
  debug "Start command", command = "init"
  result = 1
  let presets = concat(preset, args)
  result = createConfig(paths.getCurrentDir() / ".age.toml".Path, presets)
