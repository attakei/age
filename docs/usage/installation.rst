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

           curl -L https://github.com/attakei/age/releases/download/v0.10.1/age-v0.10.1_macos_arm64.zip | bsdtar x -
           chmod +x age-v0.10.1/age
           cp age-v0.10.1/age /path/to/bin/

    .. tab-item:: Linux

        .. code:: console

           curl -L https://github.com/attakei/age/releases/download/v0.10.1/age-v0.10.1_linux_x86-64.zip | bsdtar x -
           chmod +x age-v0.10.1/age
           cp age-v0.10.1/age /path/to/bin/

Using aqua
----------

`aqua <https://aquaproj.github.io/>`_ is CLI version manager for cross-platform.

We provide custom registry for aqua.
You can install by using registry.

.. code-block:: yaml
    :name: aqua.yaml

    registries:
    - type: standard
      ref: v4.371.2 # renovate: depName=aquaproj/aqua-registry
    # Add
    - name: attakei/age
      type: github_content
      repo_owner: attakei
      repo_name: age
      ref: main
      path: registry.yaml

.. code-block:: yaml
    :name: aqua-policy.yaml

    registries:
      - type: standard
        ref: semver(">= 3.0.0")
      # Add
      - name: attakei/age
        type: github_content
        repo_owner: attakei
        repo_name: age
        ref: main
        path: registry.yaml
    packages:
      - registry: standard
      - registry: attakei/age

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
