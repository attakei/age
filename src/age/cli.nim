##[CLI subcommand works.
]##
import std/[logging, paths, sequtils]
import confutils
import ./[config, engine, info, init, versioning]

type
  Command* = enum
    info = "Display config"
    update = "Update target specified version"
    major = "Update target for \"major\" level updated version"
    minor = "Update target for \"minor\" level updated version"
    patch = "Update target for \"patch\" level updated version"
    init = "Create configuration file"

  UpdateOptions* = object
    args* {.argument, desc: "Version text to replace".}: seq[string]

  InitOptions* = object
    presets* {.name: "preset", desc: "List of presets".}: seq[string]
    args* {.argument, desc: "List of presets".}: seq[string]

  AppConf* = object
    case command* {.command.}: Command
    of update:
      updateOpts* {.flatten.}: UpdateOptions
    of init:
      initOpts* {.flatten.}: InitOptions
    of major, minor, patch, info:
      discard

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
  let engine = newEngine(conf[0], conf[0].currentVersion.incrementMajor)
  result = engine.run()

proc minor*(): int =
  ## Update target for "minor" level updated version.
  debug("Call 'minor' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.incrementMinor)
  result = engine.run()

proc patch*(): int =
  ## Update target for "patch" level updated version.
  debug("Call 'patch' command.")
  result = 1
  let conf = autoConfig()
  let engine = newEngine(conf[0], conf[0].currentVersion.incrementPatch)
  result = engine.run()

proc init*(preset: seq[string] = @[], args: seq[string]): int =
  ## Create configuration file.
  debug("Call 'init' command.")
  result = 1
  let presets = concat(preset, args)
  result = createConfig(paths.getCurrentDir() / ".age.toml".Path, presets)
