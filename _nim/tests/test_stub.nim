
import unittest

import age/cli

test "stdout":
  check run() == "age v0.7.0"
