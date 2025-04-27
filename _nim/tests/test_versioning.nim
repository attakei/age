import
  unittest
import
  semver
import
  age/versioning

suite "Version.upMajor":
  test "Force change major version":
    check(newVersion(1, 2, 3).newMajorVersion() == newVersion(2, 0, 0))
    check(newVersion(1, 0, 3).newMajorVersion() == newVersion(2, 0, 0))
    check(newVersion(1, 2, 0).newMajorVersion() == newVersion(2, 0, 0))
    check(newVersion(0, 1, 2).newMajorVersion() == newVersion(1, 0, 0))

  test "Force change minor version":
    check(newVersion(1, 2, 3).newMinorVersion() == newVersion(1, 3, 0))
    check(newVersion(1, 0, 3).newMinorVersion() == newVersion(1, 1, 0))
    check(newVersion(1, 2, 0).newMinorVersion() == newVersion(1, 3, 0))
    check(newVersion(0, 1, 2).newMinorVersion() == newVersion(0, 2, 0))

  test "Force change patch version":
    check(newVersion(1, 2, 3).newPatchVersion() == newVersion(1, 2, 4))
    check(newVersion(1, 0, 3).newPatchVersion() == newVersion(1, 0, 4))
    check(newVersion(1, 2, 0).newPatchVersion() == newVersion(1, 2, 1))
    check(newVersion(0, 1, 2).newPatchVersion() == newVersion(0, 1, 3))
