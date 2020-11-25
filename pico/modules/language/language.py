import os

from PySide2.QtCore import QUrl

from pico.modules.module import Module


class Language(Module):
    def __init__(self, parent=None):
        super().__init__(parent)

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
        return "LanguageModule"

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Language.qml"))

    @staticmethod
    def description() -> str:
        return None
