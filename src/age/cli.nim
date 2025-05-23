##[CLI subcommand works.
]##
import std/[logging, paths, sequtils, tables]
import semver
import ./[config, engine, info, init, versioning]

proc info*(): int =
  ## Display config.
  debug("Call 'info' command.")
  result = 1
  let conf = autoConfig()
  let workspace = newWorkspace(conf[0], conf[1], conf[2])
  result = workspace.displayInfo()

proc update*(args: seq[string]): int =
  ## Update target specified version.
  debug("Call 'update' command.")
  result = 1
  let conf = autoConfig()
  let nextVersion = parseVersion(args[0])
  let engine = newEngine(conf[0], nextVersion)
  result = engine.run()

proc major*(): int =
  ## Update target for "major" level updated version.
  debug("Call 'major' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.newMajorVersion)
  result = engine.run()

proc minor*(): int =
  ## Update target for "minor" level updated version.
  debug("Call 'minor' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.newMinorVersion)
  result = engine.run()

proc patch*(): int =
  ## Update target for "patch" level updated version.
  debug("Call 'patch' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.newPatchVersion)
  result = engine.run()

proc init*(preset: seq[string] = @[], args: seq[string]): int =
  ## Create configuration file.
  debug("Call 'init' command.")
  result = 1
  let presets = concat(preset, args)
  result = createConfig(paths.getCurrentDir() / ".age.toml".Path, presets)
