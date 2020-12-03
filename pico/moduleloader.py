import importlib
import sys

from PySide2.QtCore import QUrl, Slot, QObject, Signal, Property

from pico.utils.config import Config
from pico.utils.logger import Logger


class ModuleLoader(QObject):
    __modules = []
    _currentModuleIndex = 0

    log = Logger.getLogger(__name__)

    loadModule = Signal(QUrl)

    def __init__(self, parent=None):
        super().__init__(parent)

    @staticmethod
    def registerModuleTypes():
        ModuleLoader.log.info('Initializing ModuleLoader')

        modules = Config.get_modules()
        modules.insert(0, "Welcome")
        modules.append("Finish")

        sys.path.insert(1, '/etc')

        importedModules = importlib.import_module('pico.modules')

        try:
            importedCustomModules = importlib.import_module('pico-wizard.custom-modules')
        except ModuleNotFoundError:
            pass

        for moduleName in modules:
            if hasattr(importedModules, moduleName):
                cls = getattr(importedModules, moduleName)
                ModuleLoader.__modules.append(cls)
                cls.registerTypes()
            elif hasattr(importedCustomModules, moduleName):
                cls = getattr(importedCustomModules, moduleName)
                ModuleLoader.__modules.append(cls)
                cls.registerTypes()
            else:
                print("ERROR : Unknown module", moduleName)
                print("Exiting...")
                sys.exit(1)

    @Slot(None, result=QUrl)
    def welcomeModule(self):
        return self.__modules[0].qmlPath()

    @Slot(None, result=None)
    def nextModule(self):
        if self._hasNext():
            self._currentModuleIndex = self._currentModuleIndex + 1
            self.loadModule.emit(self.__modules[self._currentModuleIndex].qmlPath())

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
        return self._currentModuleIndex < len(self.__modules) - 1

    @Signal
    def hasNextChanged(self):
        pass

    @Signal
    def hasPreviousChanged(self):
        pass

    hasPrevious = Property(bool, _hasPrevious, notify=hasPreviousChanged)
    hasNext = Property(bool, _hasNext, notify=hasNextChanged)