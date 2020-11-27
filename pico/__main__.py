import os
import sys
import signal

from PySide2.QtCore import QUrl
from PySide2.QtQuickControls2 import QQuickStyle
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType

from pico.modules.moduleloader import ModuleLoader


def registerTypes():
    qmlRegisterType(ModuleLoader, "Pico", 1, 0, "ModuleLoader")


def __main__():
    QQuickStyle.setStyle("Material")

    app = QApplication(sys.argv)
    app.setApplicationName("pico")
    app.setApplicationDisplayName("Pico")

    registerTypes()
    ModuleLoader.registerModuleTypes()

    engine = QQmlApplicationEngine(QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "start.qml")))

    if not engine.rootObjects():
        sys.exit(-1)

    signal.signal(signal.SIGINT, signal.SIG_DFL)

    sys.exit(app.exec_())


if __name__ == "__main__":
    # execute only if run as the entry point into the program
    __main__()
