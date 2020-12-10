import os

from PySide2.QtCore import QUrl, Slot, Property, Signal, QObject, QSortFilterProxyModel, Qt, QProcess
from PySide2.QtQml import qmlRegisterType

from pico.module import Module
from pico.modules.timezone.timezonemodel import TimezoneModel
from pico.utils.logger import Logger


class Timezone(Module):
    log = Logger.getLogger(__name__)
    _filterText = ''

    def __init__(self, parent=None):
        super().__init__(__file__, parent)

        self._timezoneModel = TimezoneModel(parent)
        self._timezoneProxyModel = QSortFilterProxyModel(parent)

        self._timezoneProxyModel.setSourceModel(self._timezoneModel)
        self._timezoneProxyModel.setFilterRole(TimezoneModel.TzRole)
        self._timezoneProxyModel.setFilterCaseSensitivity(Qt.CaseInsensitive)

        self._timezoneProxyModel.setSortRole(TimezoneModel.TzRole)
        self._timezoneProxyModel.setSortCaseSensitivity(Qt.CaseInsensitive)
        self._timezoneProxyModel.sort(0, Qt.AscendingOrder)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Timezone, 'PicoWizard', 1, 0, 'TimezoneModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Timezone.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return "Timezone"

    @Signal
    def modelChanged(self):
        pass

    @Signal
    def filterTextChanged(self):
        pass

    def _getFilterText(self):
        return self._filterText

    def _setFilterText(self, text):
        self._filterText = text
        self._timezoneProxyModel.setFilterRegExp(text)

    @Property(QObject, notify=modelChanged)
    def model(self):
        return self._timezoneProxyModel

    filterText = Property(str, _getFilterText, _setFilterText, notify=filterTextChanged)

    @Slot(int, result=None)
    def setTimezone(self, tzIndex):
        timezone = self._timezoneProxyModel.data(self._timezoneProxyModel.index(tzIndex, 0), TimezoneModel.TzRole)
        self.log.debug(f'Selected Timezone : {timezone}')

        process = QProcess(self)
        args = [
            '-sf',
            os.path.join(
                '/usr',
                'share',
                'zoneinfo',
                timezone
            ),
            '/etc/localtime'
        ]

        process.start('/usr/bin/ln', args)

        process.finished.connect(self.tzCmdSuccess)
        process.error.connect(self.tzCmdFailed)

    def tzCmdSuccess(self, exitCode):
        self.log.info('Setting Timezone')

        if exitCode != 0:
            self.setTimezoneFailed.emit()
        else:
            self.setTimezoneSuccess.emit()

    def tzCmdFailed(self, err):
        self.log.error(err)
        self.setTimezoneFailed.emit()

    @Signal
    def setTimezoneSuccess(self):
        pass

    @Signal
    def setTimezoneFailed(self):
        pass


if __name__ == "__main__":
    obj = Timezone()
    obj.getTimezones()
