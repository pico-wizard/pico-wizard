# SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
#
# SPDX-License-Identifier: MIT

import sys
import configparser
from . import constants as conf
from PicoWizard.utils.logger import Logger


class Config:
    # TODO: Check if this should be singleton class or static implementation is fine

    log = Logger.getLogger(__name__)
    config = None

    @staticmethod
    def __getConfig__(config_section, config_name, fallback=''):
        if Config.config is None:
            Config.config = configparser.ConfigParser()
            read_files = Config.config.read(conf.CONFIG_FILE_PATH)
            if len(read_files) == 0:
                Config.log.error('Could not find or open config file ' + conf.CONFIG_FILE_PATH)
                sys.exit(1)
                
        return Config.config[config_section].get(config_name, fallback=fallback)

    @staticmethod
    def getModules():
        modules_value = Config.__getConfig__('GENERAL', 'MODULES')
        modules = [x.strip() for x in modules_value.split(",") if len(x) > 0]

        return modules

    @staticmethod
    def getPasswordType():
        passwordType = Config.__getConfig__('GENERAL', 'PASSWORD_TYPE', 'alphanumeric')

        return passwordType

    @staticmethod
    def getLogLevel():
        logLevel = Config.__getConfig__('GENERAL', 'LOGLEVEL', 'info')
        print(f"loglevel: {logLevel.upper()}")

        return logLevel.upper()
