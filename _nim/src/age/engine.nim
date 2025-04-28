##[Core engine to convert files.
]##
import
  std/[asyncdispatch, asyncfile, hashes, logging, paths, re, strformat, strutils, tables, times]
import mustache, semver
import ./config

type
  Engine = ref object
    ##[Replacement engine as core of age.

    This is core object type to set settings and run main procedures.
    ]##
    runningDatetime: DateTime ## Running datetime
    currentVersion: Version ## Current version before running procs.
    nextVersion: Version ## Next version after running procs.
    rules*: Table[Path, seq[Rule]] ## Ruleset to replace targets.

  Rule = ref object
    ##[Rule definition.

    It defines these for a file.

    - What and how does it find replace target.
    - What does it replace for.
    ]##
    search: string ## Searching token. It can set as template string.
    replace: string ## Replacement text. It can set as template string too.
    regex: bool ## Flag to run regular expression for searching.    

# --
# Overloads
# --

proc hash(x: Path): Hash =
  # To use Path type as key directly.
  return hash(x.string)

proc castValue(value: Version): Value =
  # To render Version type to mustache template.
  result = Value(kind: vkString, vString: $value)

proc castValue(value: DateTime): Value =
  # To render DateTime type to mustache template.
  let newValue = new(Table[string, Value])
  newValue["date"] = Value(kind: vkString, vString: value.format("yyyy-MM-dd"))
  result = Value(kind: vkTable, vTable: newValue)

# --
# Methods
# --

proc registerRule(self: var Engine, target: Path, rule: Rule) =
  ##[Append new rule definition.

  These rules apply in order of registered  per files when running procs.

  :param target: Applyment target.
  :param rule: Rule definition for file.
  ]##
  if not self.rules.contains(target):
    self.rules[target] = newSeq[Rule]()
  self.rules[target].add(rule)

proc createTemplateContext(self: Engine): Context =
  ##[Retieve context(dataset) for updating targets.
  ]##
  result = newContext()
  result["current_version"] = self.currentVersion
  result["new_version"] = self.nextVersion
  result["now"] = self.runningDatetime

proc run*(self: Engine): int =
  ##[Works main procedure to edit targets.
  ]##
  result = 0
  info(fmt"Updating v{self.currentVersion} -> v{self.nextVersion}")
  info(fmt"Apply {self.rules.len} rules.")
  for target, rules in self.rules.pairs:
    info(fmt"Target: {target.string}")
    var content: string
    block:
      let file = openAsync(target.string, fmRead)
      content = waitFor(file.readAll())
      file.close()
    let ctx = self.createTemplateContext()
    for rule in rules:
      let replace = rule.replace.render(ctx)
      let search = rule.search.render(ctx)
      if rule.regex:
        let regex = re(rule.search)
        content = content.replace(regex, replace)
      else:
        content = content.replace(search, replace)
    block:
      let file = openAsync(target.string, fmWrite)
      waitFor(file.write(content))
      file.close()

# --
# Constructors
# --

proc newEngine*(currentVersion: Version, nextVersion: Version): Engine =
  ##[Create new instance of engine.
  
  Initialized engine has datetime snapshot to called proc and empty ruleset.

  :param currentVersion: Current version info to run proc.
  :param nextVersion: Next version info to run procs.
  ]##
  result = Engine()
  result.currentVersion = currentVersion
  result.nextVersion = nextVersion
  result.runningDatetime = now()
  result.rules = initTable[Path, seq[Rule]]()

proc newEngine*(config: Config, nextVersion: Version): Engine =
  result = newEngine(config.currentVersion, nextVersion)
  for fileConfig in config.files:
    let rule = Rule(
      search: fileConfig.search, replace: fileConfig.replace, regex: fileConfig.regex
    )
    result.registerRule(fileConfig.path, rule)
