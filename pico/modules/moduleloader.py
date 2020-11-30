import importlib
import sys
import os

from PySide2.QtCore import QUrl, Slot, QObject, Signal, Property
from PySide2.QtQml import qmlRegisterType

from pico.utils.config import Config
from pico.utils.logger import Logger


class ModuleLoader(QObject):
    _modules = []
    _currentModuleIndex = 0

    log = Logger.getLogger(__name__)

    loadModule = Signal(QUrl)

    def __init__(self, parent=None):
        super().__init__(parent)

        self.log.info('Initializing ModuleLoader')

        modules = Config.get_modules()
        modules.insert(0, "Welcome")
        modules.append("Finish")

        for moduleName in modules:
            try:
                self._modules.append(getattr(importlib.import_module('pico.modules'), moduleName))
            except AttributeError:
                print("ERROR : Unknown module", moduleName)
                print("Exiting...")
                sys.exit(1)

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

    @Slot(None, result=QUrl)
    def welcomeModule(self):
        return self._modules[0].qmlPath()

    @Slot(None, result=None)
    def nextModule(self):
        if self._hasNext():
            self._currentModuleIndex = self._currentModuleIndex + 1
            self.loadModule.emit(self._modules[self._currentModuleIndex].qmlPath())

            self.hasPreviousChanged.emit()
            self.hasNextChanged.emit()

    @Slot(None, result=None)
    def previousModule(self):
        if self._hasPrevious():
            self._currentModuleIndex = self._currentModuleIndex - 1

            self.hasPreviousChanged.emit()
            self.hasNextChanged.emit()

    def _hasPrevious(self):
        return self._currentModuleIndex > 0

    def _hasNext(self):
        return self._currentModuleIndex < len(self._modules) - 1

    @Signal
    def hasNextChanged(self):
        pass

    @Signal
    def hasPreviousChanged(self):
        pass

    hasPrevious = Property(bool, _hasPrevious, notify=hasPreviousChanged)
    hasNext = Property(bool, _hasNext, notify=hasNextChanged)
