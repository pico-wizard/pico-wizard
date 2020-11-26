import importlib
import sys
import os

from PySide2.QtCore import QUrl, Slot, QObject, Signal, Property
from PySide2.QtQml import qmlRegisterType

from pico.utils.constants import CONFIG_FILE_PATH


class ModuleLoader(QObject):
    _defaultModuleConfig = ['Welcome\n', 'Language\n']
    _modules = []

    loadModule = Signal(QUrl)

    def __init__(self, parent=None):
        super().__init__(parent)

        try:
            with open(CONFIG_FILE_PATH, 'r') as fd:
                lines = fd.readlines()
        except IOError:
            lines = self._defaultModuleConfig

            print("Cannot read", CONFIG_FILE_PATH)
            print("Using default configuration :\n  " + "  ".join(lines))

        for line in lines:
            moduleName = line.strip()

            try:
                self._modules.append(getattr(importlib.import_module('pico.modules'), moduleName))
            except AttributeError:
                print("ERROR : Unknown module", moduleName)
                print("Exiting...")
                sys.exit(1)

        self.currentModuleIndex = -1

    @staticmethod
    def registerModuleTypes():
        _modules = importlib.import_module('pico.modules')
        for name, cls in _modules.__dict__.items():
            if isinstance(cls, type):
                qmlRegisterType(
                    cls,
                    cls.qmlModuleUri(),
                    cls.qmlModuleVersionMajor(),
                    cls.qmlModuleVersionMinor(),
                    cls.qmlModuleName()
                )

    @Slot(None, result=None)
    def nextModule(self):
        if self._hasNext():
            self.currentModuleIndex = self.currentModuleIndex + 1
            self.loadModule.emit(self._modules[self.currentModuleIndex].qmlPath())

            self.hasPreviousChanged.emit()
            self.hasNextChanged.emit()

    @Slot(None, result=None)
    def previousModule(self):
        if self._hasPrevious():
            self.currentModuleIndex = self.currentModuleIndex - 1

            self.hasPreviousChanged.emit()
            self.hasNextChanged.emit()

    def _hasPrevious(self):
        return self.currentModuleIndex > 0

    def _hasNext(self):
        return self.currentModuleIndex < len(self._modules) - 1

    @Signal
    def hasNextChanged(self):
        pass

    @Signal
    def hasPreviousChanged(self):
        pass

    hasPrevious = Property(bool, _hasPrevious, notify=hasPreviousChanged)
    hasNext = Property(bool, _hasNext, notify=hasNextChanged)
