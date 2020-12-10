import os
import subprocess
import sys

from PySide2.QtCore import QUrl, Slot
from PySide2.QtQml import qmlRegisterType

from pico.module import Module

from pico.utils.logger import Logger

class User(Module):
    log = Logger.getLogger(__name__)

    def __init__(self, parent=None):
        super().__init__(__file__, parent)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(User, 'PicoWizard', 1, 0, 'UserModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "User.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return self.tr("User Configuration")

    @Slot(str, str, result=None)
    def createUser(self, username, password):
        try:
            subprocess.run(['useradd', '--create-home', '-p', password, username])
        except:
            User.log.error('Could not create user')
