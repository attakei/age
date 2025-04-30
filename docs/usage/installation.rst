===========
Install age
===========

At first, you need install age into your machine.

Patterns
========

You can age by some approach.

Get built binary
----------------

You can download and use from GitHub Releases.

.. tab-set::

    .. tab-item:: Windows

        .. todo:: Write recommend installation.

    .. tab-item:: macOS (Intel Mac)

        .. code:: console

           curl -L https://github.com/attakei/age/releases/download/v0.7.0/age-v0.7.0_macos_arm64.zip | bsdtar x -
           chmod +x age-v0.7.0/age
           cp age-v0.7.0/age /path/to/bin/

    .. tab-item:: Linux

        .. code:: console

           curl -L https://github.com/attakei/age/releases/download/v0.7.0/age-v0.7.0_linux_x86-64.zip | bsdtar x -
           chmod +x age-v0.7.0/age
           cp age-v0.7.0/age /path/to/bin/

Using Nimble
------------

.. todo:: This is only plan yet.

You can install by ``nimble install`` command,
if you are user or developer of Nim-lang and there is Nim environment on your machine.

This is suitable for:

* Want to manage cargo-driven files on single workspace.
* Want to use with latest source.

.. code:: console

   nimble install age@0.7.0

When you want to install other version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. todo:: Write later.

After install
=============

Please try running ``age`` command to check installed rightly.

.. code:: console

   age --version

When console displays version-text, Installation is successfully!!
