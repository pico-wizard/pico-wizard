import os

from PySide2.QtCore import QUrl, Slot
from PySide2.QtQml import qmlRegisterType

from pico.modules.module import Module


class Wifi(Module):
    def __init__(self, parent=None):
        super().__init__(__file__, parent)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Wifi, 'Pico', 1, 0, 'WifiModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Wifi.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Wifi"
