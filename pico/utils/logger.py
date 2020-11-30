import logging
import logging.handlers
# from .constants import LOG_FILE_PATH


class Logger:
    LOG_FILE_PATH = '/var/log/pico-wizard/pico.log'

    @staticmethod
    def getLogger(name):
        # Logging settings
        formatter = logging.Formatter(
            fmt='%(asctime)s %(name)s [%(levelname)-8s] %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        handler = logging.handlers.RotatingFileHandler(Logger.LOG_FILE_PATH, maxBytes=1000*1000*10, backupCount=10)
        handler.setFormatter(formatter)
        screenHandler = logging.StreamHandler()
        screenHandler.setFormatter(formatter)
        logger = logging.getLogger(name)
        logger.setLevel(logging.DEBUG)

        logger.addHandler(handler)
        logger.addHandler(screenHandler)

        return logger


if __name__ == "__main__":
    log = Logger.getLogger('sampleLogger')
    log.info('Testing logger')
