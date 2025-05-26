import std/os

# Package

version = "0.10.2"
author = "Kazuya Takei"
description = "Portable version-bumping tool"
license = "Apache-2.0"
srcDir = "src"
binDir = "dist"
installExt = @["nim"]
bin = @["age"]

# Dependencies

requires "nim >= 2.0.0"

requires "cligen >= 1.5.0"
requires "mustache >= 0.4.3"
requires "parsetoml >= 0.7.2"
requires "semver >= 1.2.0"

# Extra tasks

task bundle, "Bundle resources for distribution":
  let
    binExt =
      when defined(windows):
        ".exe"
      else:
        ""
    bundleDir = binDir & DirSep & "age-v" & version
  mkDir(bundleDir)
  for b in bin:
    let src = binDir & "/" & b & binExt
    let dst = bundleDir & DirSep & b & binExt
    cpFile(src, dst)
  for f in @["LICENSE", "README.md"]:
    cpFile(f, bundleDir & DirSep & f)
