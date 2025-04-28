##[Configuration manager.
]##
import std/[os, paths, re, tables]
import parsetoml, semver

type
  Config* = ref object ##[Configuration properties.
    ]##
    currentVersion*: Version ## Managed "current" version of target.
    files*: seq[FileConfig] ## Rule section per files.

  FileConfig* = ref object ##[File base rule configuration.
    ]##
    path*: Path ## Filepath of target to replace.
    search*: string ## Search text to run procs.
    replace*: string ## Replacement text to run procs.
    regex*: bool ## Flag to use regular expression for search.

  LoadError* = object of Exception

proc parseFileConfig(table: TomlTableRef): FileConfig =
  ##[Create FileConfig object from '[[files]]' section  of parsed toml file.
  ]##
  result = FileConfig(regex: false)
  result.path = table["path"].getStr.Path
  result.search = table["search"].getStr
  result.replace = table["replace"].getStr
  if "regex" in table:
    result.regex = table["regex"].getBool
    # TODO: Raise human-readable exception.
    let _ = re(result.search)

proc parseConfig(table: TomlTableRef): Config =
  ##[Create coinfiguration object from parsed toml settings.
  ]##
  result = Config()
  # TODO: Raise human-readable exception.
  result.currentVersion = parseVersion(table["current_version"].getStr)
  result.files = newSeq[FileConfig]()
  for fileToml in table["files"].getElems:
    result.files.add(parseFileConfig(fileToml.getTable))

proc parseConfig*(filePath: string): Config =
  let toml = parseFile(filePath)
  result = parseConfig(toml.getTable)

proc autoConfig*(): Config =
  ##[Resolve valid config path and parse config.
  ]##
  let candicates = [paths.getCurrentDir() / Path(".age.toml")]
  for c in candicates:
    if not fileExists(c.string):
      continue
    return parseConfig(c.string)
  raise newException(LoadError, "Config file is not found.")
