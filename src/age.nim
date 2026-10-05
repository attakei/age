#[Entrypoint.
]#
import std/strformat
import confutils
import ./age/[cli, consts]

when isMainModule:
  let conf = AppConf.load(version = fmt"{NAME} v{VERSION}")
  case conf.command
  of Command.info:
    discard info()
  of Command.update:
    discard update(conf.updateOpts.args)
  of Command.major:
    discard major()
  of Command.minor:
    discard minor()
  of Command.patch:
    discard patch()
  of Command.init:
    discard init(conf.initOpts.presets, conf.initOpts.args)
