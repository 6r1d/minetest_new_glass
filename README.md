# New glass

![](https://github.com/6r1d/minetest_new_glass/workflows/luacheck/badge.svg)

This mod provides a glowing version of steel framed obsidian glass node from
a ``framedglass`` mod. It supports many colors.

It also adds nodes, similar to a colored version of ``dark_glass`` from
``scifi_nodes`` mod.

Screenshots
===========

![](doc/screenshot.png)

![](doc/screenshot_2.png)

Installation
============

First of all, install ``unifieddyes`` and ``framedglass`` mods,
these are required for this mod to work.

These are installed from archives and metod is the same as
this mod's installation.

Move this mod directory at your minetest mod directory.
For example, in Linux it's ``/home/username/.minetest/mods/new_glass``.

You should be able to see ``init.lua`` file in this new_glass directory,
to be clear.

Usage
=====

RGB leds
--------

To reset a block state, send this digiline message:

```digiline_send('rgb', { reset = math.random(0, 1) })```

To switch glow:

```digiline_send('rgb', { switch = math.random(0, 1) })```

Finally, to change the block color:

```digiline_send('rgb', { color = math.random(0, 255) })```

License
=======

Copyright (C) 2020 Victor Gridnevsky (6r1d) and contributors. Based on [framed glass](https://github.com/minetest-mods/framedglass) mod by Maciej Kasatkin (RealBadAngel).

All code and textures are licensed under the GNU LGPLv2+.
