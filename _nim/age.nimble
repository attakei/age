# Package

version       = "0.7.0"
author        = "Kazuya Takei"
description   = "Portable version-bumping tool"
license       = "Apache-2.0"
srcDir        = "src"
binDir        = "dist"
installExt    = @["nim"]
bin           = @["age"]

# Dependencies

requires "nim >= 2.0.0"
requires "parsetoml >= 0.7.2"
requires "semver >= 1.2.0"
