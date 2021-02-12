import abc
import os

from PySide2.QtCore import QObject, QUrl, Slot, Signal


class Module(QObject):
    _filename = None

    def __init__(self, filename, parent=None):
        super().__init__(parent)
        self._filename = filename

    @staticmethod
    @abc.abstractmethod
    def registerTypes() -> None:
        pass

    @staticmethod
    @abc.abstractmethod
    def qmlPath() -> QUrl:
        pass

    @Slot(None, result=str)
    def dir(self):
        path, _ = os.path.split(os.path.abspath(self._filename))
        return path

    @Slot(None, result=str)
    def moduleName(self) -> str:
        pass

    errorOccurred = Signal(str)
