import os
from queue import SimpleQueue

import PySide2
from PySide2.QtCore import QUrl, Slot, Signal, Property, QTimer, QProcess
from PySide2.QtQml import qmlRegisterType

from PicoWizard.module import Module
from PicoWizard.utils.constants import SCRIPTS_DIR
from PicoWizard.utils.logger import Logger


class Finish(Module):
    log = Logger.getLogger(__name__)

    _isComplete = False
    _runningScriptIndex = -1
    _totalScriptsCount = -1

    def __init__(self, parent=None):
        super().__init__(__file__, parent)
        self._scriptsQueue = SimpleQueue()

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Finish, 'PicoWizard', 1, 0, 'FinishModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Finish.qml"))

    def _getIsComplete(self):
        return self._isComplete

    def _getRunningScriptIndex(self):
        return self._runningScriptIndex

    def _getTotalScriptsCount(self):
        return self._totalScriptsCount

    def _processScripts(self):
        if self._scriptsQueue.empty():
            self._isComplete = True
            self.isCompleteChanged.emit()
        else:
            script = self._scriptsQueue.get()
            self._runningScriptIndex += 1
            self.runningScriptIndexChanged.emit()

            self.log.info(f'Running Script [{script.program().rpartition("/")[2]}]')

            script.finished.connect(lambda exitCode: self._scriptFinishedHandler(script, exitCode))
            script.errorOccurred.connect(lambda error: self._scriptErroredHandler(script, error))
            script.readyReadStandardOutput.connect(lambda: self.log.info(f'Output: {script.readAllStandardOutput()}'))

            script.start()

    def _scriptFinishedHandler(self, script, exitCode):
        self.log.info(f'Script [{script.program().rpartition("/")[2]}] Finished: Exit code ({exitCode})')
        self._processScripts()

    def _scriptErroredHandler(self, script, error):
        self.log.info(f'Script [{script.program().rpartition("/")[2]}] Errored: {error}')
        self._processScripts()

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Finish"

    @Slot(None)
    def runScripts(self):
        if os.path.exists(SCRIPTS_DIR):
            scripts = os.listdir(SCRIPTS_DIR)
            scripts.sort()

            self._totalScriptsCount = len(scripts)
            self.totalScriptsCountChanged.emit()

            for script in scripts:
                args = [os.path.join(SCRIPTS_DIR, script)]
                process = QProcess(self)
                process.setProgram('/usr/bin/pkexec')
                process.setArguments(args)

                self._scriptsQueue.put(process)

        self._processScripts()

    @Signal
    def isCompleteChanged(self):
        pass

    @Signal
    def runningScriptIndexChanged(self):
        pass

    @Signal
    def totalScriptsCountChanged(self):
        pass

    isComplete = Property(bool, _getIsComplete, notify=isCompleteChanged)
    runningScriptIndex = Property(int, _getRunningScriptIndex, notify=runningScriptIndexChanged)
    totalScriptsCount = Property(int, _getTotalScriptsCount, notify=totalScriptsCountChanged)