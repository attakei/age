import std/unittest
import age/version

suite "Version type itself":
  test "initialize":
    check $initVersion() == "0.0.0"
    check initVersion().semver == "0.0.0"

  test "compare":
    check initVersion(prefix = "v") == initVersion()
    check initVersion(1) > initVersion(0)
    check initVersion(2, 2, 3) > initVersion(1, 2, 3)
    check initVersion(1, 3, 3) > initVersion(1, 2, 3)
    check initVersion(1, 2, 4) > initVersion(1, 2, 3)
    check initVersion(1, 2, 3) < initVersion(2, 2, 3)
    check initVersion(2, 2, 3) >= initVersion(1, 2, 3)
    check initVersion(1, 2, 3) >= initVersion(1, 2, 3)
    check initVersion(1, 2, 3) == initVersion(1, 2, 3)

  test "update versions":
    let version = initVersion(1, 2, 3)
    check $version.incrementMajor == "2.0.0"
    check $version.incrementMajor(2) == "3.0.0"
    check $version.incrementMinor == "1.3.0"
    check $version.incrementMinor(2) == "1.4.0"
    check $version.incrementPatch == "1.2.4"
    check $version.incrementPatch(2) == "1.2.5"

  test "update versions with suffix":
    let version = initVersion(1, 2, 3, suffix = "a1")
    check $version.incrementMajor == "2.0.0a1"
    check $version.incrementMajor(keepSuffix = false) == "2.0.0"
    check $version.incrementMinor == "1.3.0a1"
    check $version.incrementMinor(keepSuffix = false) == "1.3.0"
    check $version.incrementPatch == "1.2.4a1"
    check $version.incrementPatch(keepSuffix = false) == "1.2.4"

  test "parse version text":
    block:
      let version = parseVersion("v1.2.3dev1")
      check version.major == 1
      check version.minor == 2
      check version.patch == 3
      check version.prefix == "v"
      check version.suffix == "dev1"
    check parseVersion("version-2.3.4rc1").semver == "2.3.4"
    check parseVersion("version2.3.4").semver == "2.3.4"
    check parseVersion("version2.3.4").prefix == "version"
    check parseVersion("version2.3.4").suffix == ""
    check parseVersion("2.3.4a1").semver == "2.3.4"
    check parseVersion("2.3.4a1").prefix == ""
    check parseVersion("2.3.4a1").suffix == "a1"
