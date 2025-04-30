import unittest
include age/config

suite "Test for parseFileConfig":
  test "simple test":
    let table = parsetoml.parseString(
      """
      path = "pyproject.toml"
      search = "version = \"{{current_version}}\""
      replace = "version = \"{{new_version}}\""
    """
    )
    let conf = parseFileConfig(table.getTable)
    check(conf.path == "pyproject.toml".Path)
    check(conf.search == "version = \"{{current_version}}\"")
    check(conf.replace == "version = \"{{new_version}}\"")
    check(not conf.regex)

  test "use regexp search":
    let table = parsetoml.parseString(
      """
      path = "pyproject.toml"
      search = "(.+)"
      replace = "version = \"{{new_version}}\""
      regex = true
    """
    )
    let conf = parseFileConfig(table.getTable)
    check(conf.regex)

  test "use regexp search, but invalid":
    let table = parsetoml.parseString(
      """
      path = "pyproject.toml"
      search = "(.+"
      replace = "version = \"{{new_version}}\""
      regex = true
    """
    )
    expect ValueError:
      let conf = parseFileConfig(table.getTable)

suite "Test for parseConfig":
  # TODO: Change checks when Nim codebase is mainstream.
  test "Use current .age.toml":
    let table = parseFile(".age.toml") # Ref to project root.
    let conf = parseConfig(table.getTable)
    check(conf.currentVersion >= parseVersion("0.7.0"))
    check(conf.files.len > 0)

  test "Invalid version":
    let table = parsetoml.parseString(
      """
      current_version = "dev"
    """
    )
    expect ValueError:
      let conf = parseConfig(table.getTable)
