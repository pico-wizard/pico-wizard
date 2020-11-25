import abc

from PySide2.QtCore import QObject, QUrl


class Module(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

    @staticmethod
    @abc.abstractmethod
    def qmlModuleUri() -> str:
        pass

    @staticmethod
    @abc.abstractmethod
    def qmlModuleVersionMajor() -> int:
        pass

    @staticmethod
    @abc.abstractmethod
    def qmlModuleVersionMinor() -> int:
        pass

    @staticmethod
    @abc.abstractmethod
    def qmlModuleName() -> str:
        pass

    @staticmethod
    @abc.abstractmethod
    def qmlPath() -> QUrl:
        pass

    @staticmethod
    @abc.abstractmethod
    def description() -> str:
        pass
