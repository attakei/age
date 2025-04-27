## CLI handler.
import
  std/strformat
import
  ./consts

proc run*(): string =
  result = fmt"{NAME} v{VERSION}"
