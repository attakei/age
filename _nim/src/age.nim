#[Entrypoint.
]#
import std/strformat
import cligen
import ./age/[cli, consts]

when isMainModule:
  clCfg.version = fmt"{NAME} v{VERSION}"
  dispatchMulti([info], [update], [major], [minor], [patch], [init])
