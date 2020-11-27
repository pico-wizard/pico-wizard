import configparser
from . import constants as conf


class Config:
    # TODO: Check if this should be singleton class or static implementation is fine

    config = None

    @staticmethod
    def __get_cofig(self, config_section, config_name):
        if self.config is None:
            self.config = configparser.ConfigParser()
            read_files = self.config.read(conf.CONFIG_FILE_PATH)
            if len(read_files) == 0:
                raise ValueError('Could not find or open config file ' + conf.CONFIG_FILE_PATH)

        return self.config[config_section][config_name]

    @staticmethod
    def get_modules(self):
        modules_value = self.__get_config()
        modules = [x.strip() for x in modules_value.split(",")]

        return modules
