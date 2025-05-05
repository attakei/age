===========================
Templating in file settings
===========================

``search`` and ``replace`` of ``[[files]]`` section can use Mustache based template.

Variables
=========

``current_version``
-------------------

Current version text before running ``age``.

``new_version``
---------------

Next version text after running ``age``.

``now``
-------

Datetime text that ``age`` called.

``nowFormat``
-------------

Formatted string of ``now``.

* ``now.dateISO``: Date part of ISO 8601 Format.

Lambdas
=======

Lambdas can use as template block.

``sameLengthChars``
-------------------

Render strings repeated ``arg1`` as same length as ``arg2``.
In block, ``arg1`` and ``arg2`` are joined by '@'.

Example:

.. code-block:: text

    Example
    {{#sameLengthChars}}=@Example{{/sameLengthChars}}

Finally rendered:

.. code-block:: text

    Example
    =======
