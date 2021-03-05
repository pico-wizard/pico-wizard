# SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
#
# SPDX-License-Identifier: MIT

import os

from PySide2.QtCore import QUrl, Slot, Property, QObject, Signal, QSortFilterProxyModel, Qt
from PySide2.QtQml import qmlRegisterType

from PicoWizard.module import Module
from PicoWizard.modules.locale.localemodel import LocaleModel
from PicoWizard.modules.locale.localeslist import locales


class Locale(Module):
    __filterText__ = ''

    def __init__(self, parent=None):
        super().__init__(__file__, parent)

        self.__localeModel__ = LocaleModel(parent)
        self.__localeProxyModel__ = QSortFilterProxyModel(parent)

        self.__localeProxyModel__.setSourceModel(self.__localeModel__)
        self.__localeProxyModel__.setFilterRole(LocaleModel.Roles.NameRole)
        self.__localeProxyModel__.setFilterCaseSensitivity(Qt.CaseInsensitive)

        self.__localeProxyModel__.setSortRole(LocaleModel.Roles.NameRole)
        self.__localeProxyModel__.setSortCaseSensitivity(Qt.CaseInsensitive)
        self.__localeProxyModel__.sort(0, Qt.AscendingOrder)

        for locale in locales:
            self.__localeModel__.addLocaleItem(locale)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Locale, 'PicoWizard', 1, 0, 'LocaleModule')
        qmlRegisterType(LocaleModel, 'PicoWizard', 1, 0, 'LocaleModel')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Locale.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return self.tr("Locale")

    @Signal
    def modelChanged(self):
        pass

    @Property(QObject, notify=modelChanged)
    def model(self):
        return self.__localeProxyModel__

    @Signal
    def filterTextChanged(self):
        pass

    def __getFilterText__(self):
        return self.__filterText__

    def __setFilterText__(self, text):
        self.__filterText__ = text
        self.__localeProxyModel__.setFilterRegExp(text)

    filterText = Property(str, __getFilterText__, __setFilterText__, notify=filterTextChanged)
