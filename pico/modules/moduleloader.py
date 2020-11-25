import importlib

from PySide2.QtCore import QUrl, Slot, QObject, Signal, Property
from PySide2.QtQml import qmlRegisterType


class ModuleLoader(QObject):
    loadNextModule = Signal(QUrl)

    def __init__(self, parent=None):
        super().__init__(parent)

        with open('/etc/pico/modules.conf', 'r') as fd:
            lines = fd.readlines()

        self.modules = [getattr(importlib.import_module('pico.modules'), x.strip()) for x in lines]
        self.currentModuleIndex = -1

    @staticmethod
    def registerModuleTypes():
        _modules = importlib.import_module('pico.modules')
        for name, cls in _modules.__dict__.items():
            if isinstance(cls, type):
                qmlRegisterType(cls, 'Pico', 1, 0, cls.qml_module_name())

    @Slot(None, result=None)
    def nextModule(self):
        if self._hasNext():
            self.currentModuleIndex = self.currentModuleIndex+1
            self.loadNextModule.emit(self.modules[self.currentModuleIndex].qml_path())
            self.hasPreviousChanged.emit()
            self.hasNextChanged.emit()

    @Slot(None, result=None)
    def previousModule(self):
        if self._hasPrevious():
            self.currentModuleIndex = self.currentModuleIndex-1
            self.loadNextModule.emit(self.modules[self.currentModuleIndex].qml_path())
            self.hasPreviousChanged.emit()
            self.hasNextChanged.emit()

    def _hasPrevious(self):
        return self.currentModuleIndex > 0

    def _hasNext(self):
        return self.currentModuleIndex < len(self.modules)-1

    @Signal
    def hasNextChanged(self):
        pass

    @Signal
    def hasPreviousChanged(self):
        pass

    hasPrevious = Property(bool, _hasPrevious, notify=hasPreviousChanged)
    hasNext = Property(bool, _hasNext, notify=hasNextChanged)

