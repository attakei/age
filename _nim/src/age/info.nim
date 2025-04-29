##[Main logic for 'info' subcommand.
]##
import std/[paths, sequtils]
import mustache
import ./[config, versioning]

const DISPLAY_TEMPLATE =
  """
# Workspace

- Root: {{ workspace_root|safe }}
- File: {{ workspace_file|safe }}

# Version info

- Current:    {{ current_version }}
- Next major: {{ next_major }}
- Next minor: {{ next_minor }}
- Next patch: {{ next_patch }}

# Replace targets

{% for f in files -%}
- {{ f|safe }}
{% endfor -%}
"""

type Workspace = ref object
  root: Path
  file: Path
  config: Config

proc castValue(value: Path): Value =
  result = Value(kind: vkString, vString: value.string)

proc displayInfo*(self: Workspace): int =
  result = 1
  let ctx = newContext()
  ctx["workspace_root"] = self.root
  ctx["workspace_file"] = self.file
  ctx["current_versoin"] = self.config.currentVersion
  ctx["next_major"] = self.config.currentVersion.newMajorVersion
  ctx["next_minor"] = self.config.currentVersion.newMinorVersion
  ctx["next_patch"] = self.config.currentVersion.newPatchVersion
  ctx["files"] = self.config.files.mapIt(it.path.string).deduplicate
  echo DISPLAY_TEMPLATE.render(ctx)
  result = 0

proc newWorkspace*(config: Config, path: Path, workDir: Path): Workspace =
  result = Workspace()
  result.root = workDir
  result.file = path
  result.config = config
