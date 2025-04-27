## Handler versioning.
##
## This module depends on that this project uses Semantic Versioning.
import
  semver


proc newMajorVersion*(ver: Version): Version =
  ## Create new version struct that is updated as "Major version up".
  return newVersion(ver.major + 1, 0, 0)

proc newMinorVersion*(ver: Version): Version =
  ## Create new version struct that is updated as "Minor version up".
  return newVersion(ver.major, ver.minor + 1, 0)

proc newPatchVersion*(ver: Version): Version =
  ## Create new version struct that is updated as "Patch version up".
  return newVersion(ver.major, ver.minor, ver.patch + 1)
