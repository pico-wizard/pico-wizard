import abc
import os

from PySide2.QtCore import QObject, QUrl, Slot


class Module(QObject):
    _filename = None

    def __init__(self, filename, parent=None):
        super().__init__(parent)
        self._filename = filename

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

    @Slot(None, result=str)
    def dir(self):
        path, _ = os.path.split(os.path.abspath(self._filename))
        return path
