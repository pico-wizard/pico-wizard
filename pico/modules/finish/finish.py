import os

from PySide2.QtCore import QUrl, Slot
from PySide2.QtQml import qmlRegisterType

from pico.modules.module import Module


class Finish(Module):
    def __init__(self, parent=None):
        super().__init__(__file__, parent)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Finish, 'Pico', 1, 0, 'FinishModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Finish.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Finish"
