=============
Configuration
=============

You need setup age's configuration on your project.

First setup
===========

After install, you can get configuration file as ``.age.toml`` or ``age.toml`` by running command ``age init``.

.. code-block:: console
   :caption: Simple project

   age init

.. code-block:: console
   :caption: For Python project

   age init --preset python

If you want to using sample, Please see `configuration file of project itself <https://github.com/attakei/age/blob/main/.age.toml>`_.

Configuration values
====================

``current_version``
-------------------

Version text managed by age.

.. warning::

   This is auto-updated value by age.
   Do not edit manually.

``files``
---------

List of target to replace by age.

.. code-block:: toml
   :caption: Simple example

   [[files]]
   path = "Cargo.toml"
   search = "version = \"{{current_version}}\""
   replace = "version = \"{{new_version}}\""

``files[].path``
----------------

File path of replacement target.
This should be relative path of configuration file.

``files[].search``
------------------

Search target of file.
This accepts multi-line text and using templating.

This value supports template text. Please see :doc:`./templating`.

``files[].regex``
------------------

:Required: No
:Default: ``false``

Flag to use regular expression (regex) when searching target.

If it is ``true``, age search target using regex and replace text with captured text.

Syntax of regex follows `nim-regex <https://nitely.github.io/nim-regex/regex.html#syntax>`_.
It is similar to Rust's regex, and there are some differences from PCRE.

- Named capture group must be written as ``(?P<name>...)``. ``(?<name>...)`` is not supported.
- ``files[].replace`` can refer captured groups by ``$N`` (``N`` is 1-indexed number of group).
  Named reference (e.g. ``$name``) is not supported.
  If you want to write literal ``$``, use ``$$``.
- Backreferences (``\1``), atomic groups and possessive quantifiers are not supported.

.. code-block:: toml
   :caption: Example of using captured text

   [[files]]
   path = "example.txt"
   regex = true
   search = """
   version = '{{current_version}}'
   hello (?P<name>.+)
   """
   replace = """
   version = '{{new_version}}'
   hello
   from $1
   """

``files[].replace``
-------------------

Replacement text for search target of file.
This accepts multi-line text and using templating.

This value supports template text. Please see :doc:`./templating`.
