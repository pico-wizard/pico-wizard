import os

from PySide2.QtCore import QUrl, Slot
from PySide2.QtQml import qmlRegisterType

from pico.module import Module


class Timezone(Module):
    def __init__(self, parent=None):
        super().__init__(__file__, parent)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Timezone, 'PicoWizard', 1, 0, 'TimezoneModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Timezone.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Timezone"
