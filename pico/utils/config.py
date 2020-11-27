import configparser
from . import constants as conf


class Config:
    # TODO: Check if this should be singleton class or static implementation is fine

    config = None

    @staticmethod
    def __get_config(config_section, config_name):
        if Config.config is None:
            Config.config = configparser.ConfigParser()
            read_files = Config.config.read(conf.CONFIG_FILE_PATH)
            if len(read_files) == 0:
                raise ValueError('Could not find or open config file ' + conf.CONFIG_FILE_PATH)

        return Config.config[config_section][config_name]

    @staticmethod
    def get_modules():
        modules_value = Config.__get_config()
        modules = [x.strip() for x in modules_value.split(",")]

        return modules