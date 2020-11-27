import os

from PySide2.QtCore import QUrl, Slot

from pico.modules.module import Module


class Personalization(Module):
    def __init__(self, parent=None):
        super().__init__(__file__, parent)

    @staticmethod
    def qmlModuleUri() -> str:
        return "Pico"

    @staticmethod
    def qmlModuleVersionMajor() -> int:
        return 1

    @staticmethod
    def qmlModuleVersionMinor() -> int:
        return 0

    @staticmethod
    def qmlModuleName() -> str:
        return "PersonalizationModule"

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Personalization.qml"))

    @staticmethod
    def description() -> str:
        return None

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Personalization"
