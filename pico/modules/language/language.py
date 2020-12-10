import os

from PySide2.QtCore import QUrl, Slot
from PySide2.QtQml import qmlRegisterType

from pico.modules.language.languagemodel import LanguageModel
from pico.module import Module


class Language(Module):
    def __init__(self, parent=None):
        super().__init__(__file__, parent)

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Language, 'PicoWizard', 1, 0, 'LanguageModule')
        qmlRegisterType(LanguageModel, 'PicoWizard', 1, 0, 'LanguageModel')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Language.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return self.tr("Language and Input")
