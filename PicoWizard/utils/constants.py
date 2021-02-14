import os
from appdirs import AppDirs

APP_NAME = 'pico-wizard'

dirs = AppDirs(APP_NAME)

CONFIG_DIR = os.path.join('/', 'etc', 'pico-wizard')
CONFIG_FILE = 'pico-wizard.conf'
CONFIG_FILE_PATH = os.path.join(CONFIG_DIR, CONFIG_FILE)
SCRIPTS_DIR = os.path.join(CONFIG_DIR, 'scripts.d')

LOG_FILE_PATH = os.path.join(dirs.user_log_dir, "pico-wizard.log")
