import abc

from PySide2.QtCore import QObject, QUrl


class Module(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

    @staticmethod
    @abc.abstractmethod
    def qml_module_name() -> str:
        pass

    @staticmethod
    @abc.abstractmethod
    def qml_module_description() -> str:
        pass

    @staticmethod
    @abc.abstractmethod
    def qml_path() -> QUrl:
        pass
