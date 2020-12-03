import typing
from enum import Enum

import PySide2
from PySide2.QtCore import QAbstractListModel, Qt


class TimezoneModel(QAbstractListModel):
    __timezones = [
        {
            "text": "India GMT+05:30",
            "link": "Asia/India"
        },
        {
            "text": "Bangkok GMT+06:00",
            "link": "Asia/Bangkok"
        },
        {
            "text": "Dubai GMT+05:00",
            "link": "Asia/Dubai"
        }
    ]

    TextRole = Qt.UserRole + 1
    LinkRole = TextRole + 1

    def __init__(self, parent=None):
        super().__init__(parent)

    def roleNames(self) -> typing.Dict:
        roles = dict()
        roles[self.TextRole] = b'text'
        roles[self.LinkRole] = b'link'

        return roles

    def data(self, index: PySide2.QtCore.QModelIndex, role: int) -> typing.Any:
        if role == self.TextRole:
            return self.__timezones[index.row()]['text']
        elif role == self.LinkRole:
            return self.__timezones[index.row()]['link']

    def rowCount(self, parent: PySide2.QtCore.QModelIndex) -> int:
        return len(self.__timezones)

