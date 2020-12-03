import os

APP_NAME = 'pico-wizard'

CONFIG_DIR = os.path.join('/', 'etc', 'pico-wizard')
CONFIG_FILE = 'pico-wizard.conf'
CONFIG_FILE_PATH = os.path.join(CONFIG_DIR, CONFIG_FILE)

LOG_FILE = 'pico-wizard.log'
LOG_FILE_PATH = os.path.join('/', 'var', 'log', 'pico-wizard', LOG_FILE)
