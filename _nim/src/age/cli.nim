##[CLI subcommand works.
]##
import
  std/logging


proc info*(): int =
  ## Display config.
  result = 0

proc update*(args: seq[string]): int =
  ## Update target specified version.
  result = 0

proc major*(): int = 
  ## Update target for "major" level updated version.
  result = 0

proc minor*(): int = 
  ## Update target for "minor" level updated version.
  result = 0

proc patch*(): int = 
  ## Update target for "patch" level updated version.
  result = 0

proc init*(): int = 
  ## Create configuration file.
  result = 0

proc help*(): int = 
  ## Print help message.
  result = 0
