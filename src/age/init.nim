##[Main logic of 'init' subcommand.
]##
import std/[paths, strformat, strutils, tables]
import mustache

const
  TEMPLATE_BASE =
    """
current_version = "{{ current_version }}"
"""
  TEMPLATE_PRESET = {
    "rust":
      """
[[files]]
path = "Cargo.toml"
search = "version = \"{{current_version}}\""
replace = "version = \"{{new_version}}\""
""",
    "python":
      """
[[files]]
path = "pyproject.toml"
search = "version = \"{{current_version}}\""
replace = "version = \"{{new_version}}\""
""",
  }.toTable

proc createConfig*(dist: Path, presets: seq[string]): int =
  result = 1
  let ctx = newContext()
  ctx["current_version"] = "0.0.0"
  var tmplParts = @[TEMPLATE_BASE.render(ctx)]
  for p in presets:
    if not TEMPLATE_PRESET.hasKey(p):
      stderr.writeLine(fmt"{p} is invalid preset name.")
      continue
    tmplParts.add(TEMPLATE_PRESET[p])
  let file = open(dist.string, fmWrite)
  file.write(join(tmplParts, "\n"))
  file.close
  result = 0
