import os
import subprocess
from typing import Any

from PySide2.QtCore import QUrl, Slot, Property, Signal, QObject, QSortFilterProxyModel, Qt
from PySide2.QtQml import qmlRegisterType

from pico.module import Module
from pico.modules.timezone.timezonemodel import TimezoneModel


class Timezone(Module):
    _filterText = ''

    def __init__(self, parent=None):
        super().__init__(__file__, parent)

        self.__setTimezonesCommand = 'ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime'
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


if __name__ == "__main__":
    obj = Timezone()
    obj.getTimezones()
