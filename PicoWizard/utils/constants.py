# SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
#
# SPDX-License-Identifier: MIT

import os

APP_NAME = 'pico-wizard'

CONFIG_DIR = os.path.join('/', 'etc', 'pico-wizard')
CONFIG_FILE = 'pico-wizard.conf'
CONFIG_FILE_PATH = os.path.join(CONFIG_DIR, CONFIG_FILE)
SCRIPTS_DIR = os.path.join(CONFIG_DIR, 'scripts.d')

LOG_FILE_PATH = os.path.join("/tmp", "pico-wizard.log")
