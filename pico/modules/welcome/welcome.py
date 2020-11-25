import os

from PySide2.QtCore import QUrl

from pico.modules.module import Module


class Welcome(Module):
    def __init__(self, parent=None):
        super().__init__(parent)

    @staticmethod
    def qml_module_description() -> str:
        return None

    @staticmethod
    def qml_module_name() -> str:
        return "WelcomeModule"

    @staticmethod
    def qml_path() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Welcome.qml"))
