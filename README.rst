.. image:: https://github.com/pico-wizard/pico-wizard/actions/workflows/python-publish.yml/badge.svg

====
NOTE
====
Pico Wizard is now a KDE project and the codebase has been moved to https://invent.kde.org/plasma/pico-wizard

Further development will be continued in KDE Invent

===========
Pico Wizard
===========

    | A Post Installation COnfiguration Wizard for Linux OSes

Overview
--------
Pico Wizard is a setup wizard meant for configuring pre-installed oses like linux phones, raspberry pi and other embedded systems.
Currently PicoWizard is being used by ManjaroARM Plasma Mobile Image for PinePhone.

Any distro wanting to use PicoWizard as their first boot setup wizard, can start a Discussion_ or join the `Official Channels`_ for further discussion

Installation
------------

Installation over pip in 4 steps is available (run all the commands after being logged in as root user ``sudo su root``): 


1. ``pip install pico-wizard --target=/usr/bin``
2. ``wget "https://raw.githubusercontent.com/OW-DG/pico-wizard/main/genconfig.sh"``
3. ``chmod +x genconfig.sh``
4. ``./genconfig.sh``

Official Channels
-----------------
- Telegram  : https://t.me/picowizard
- Matrix    : ``#pico-wizard/general:matrix.org``

.. References
.. ----------
.. _Discussion: https://github.com/pico-wizard/pico-wizard/discussions
