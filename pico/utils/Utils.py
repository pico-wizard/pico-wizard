import configparser
from . import constants as conf


class Utils:
    def __init__(self):
        self.config = configparser.ConfigParser()

    def get_config(self, section_name, config_name):
        read_files = self.config.read(conf.CONFIG_FILE_PATH)

        if len(read_files) == 0:
            raise ValueError('Could not find or open config file ' + conf.CONFIG_FILE_PATH)

        return self.config[section_name][config_name]
