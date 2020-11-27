import configparser
from . import constants as conf


class Config:
    def __init__(self):
        if self.config is None:
            self.config = configparser.ConfigParser()
            read_files = self.config.read(conf.CONFIG_FILE_PATH)
            if len(read_files) == 0:
                raise ValueError('Could not find or open config file ' + conf.CONFIG_FILE_PATH)

    def get_modules(self):
        modules = self.config['GENERAL']['MODULES']
        modules = [x.strip() for x in modules.split(",")]

        return modules
