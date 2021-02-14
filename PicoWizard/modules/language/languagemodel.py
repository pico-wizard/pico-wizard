import typing
from enum import Enum

import PySide2
from PySide2.QtCore import QAbstractListModel, Qt


class LanguageModel(QAbstractListModel):
    __languages = [{
        'id': 'en_us',
        'name': 'English (US)'
    }, {
        'id': 'en_in',
        'name': 'English (India)'
    }, {
        'id': 'hi',
        'name': 'Hindi'
    }, {
        'id': 'be',
        'name': 'Bengali'
    }, {
        'id': 'as',
        'name': 'Assamese'
    }]

    IdRole = Qt.UserRole + 1
    NameRole = IdRole + 1

    def __init__(self, parent=None):
        super().__init__(parent)

    def roleNames(self) -> typing.Dict:
        roles = dict()
        roles[self.IdRole] = b'id'
        roles[self.NameRole] = b'name'

        return roles

    def data(self, index: PySide2.QtCore.QModelIndex, role: int) -> typing.Any:
        if role == self.IdRole:
            return self.__languages[index.row()]['id']
        elif role == self.NameRole:
            return self.__languages[index.row()]['name']

    def rowCount(self, parent: PySide2.QtCore.QModelIndex) -> int:
        return len(self.__languages)

