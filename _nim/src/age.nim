#[Entrypoint.
]#
import
  std/strformat
import
  cligen
import
  ./age/[cli, consts]

proc cli(version: bool = false, args: seq[string]): int =
  result = 1
  if version:
    result = 0
    echo(fmt"{NAME} v{VERSION}")
    return

when isMainModule:
  dispatchMulti(
    [info],
    [update],
    [major],
    [minor],
    [patch],
    [init],
    [help],
  )
