import os
import subprocess

from PySide2.QtCore import QUrl, Slot
from PySide2.QtQml import qmlRegisterType

from pico.module import Module
from pico.modules.timezone.timezonemodel import TimezoneModel


class Timezone(Module):
    def __init__(self, parent=None):
        super().__init__(__file__, parent)

        self.__setTimezonesCommand = 'ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime'

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Timezone, 'PicoWizard', 1, 0, 'TimezoneModule')
        qmlRegisterType(TimezoneModel, 'PicoWizard', 1, 0, 'TimezoneModel')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Timezone.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Timezone"

    def getTimezones(self):
        getTimezonesProcess = subprocess.Popen(self.__getTimezonesCommand,
                                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)
        result_stdout, result_stderr = getTimezonesProcess.communicate()

        print(result_stdout)
        print(result_stderr)


if __name__ == "__main__":
    obj = Timezone()
    obj.getTimezones()
