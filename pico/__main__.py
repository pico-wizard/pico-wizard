import argparse
import os
import signal
import sys

from PySide2.QtCore import QUrl
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtQuickControls2 import QQuickStyle
from PySide2.QtWidgets import QApplication

from pico.utils.logger import Logger


def registerTypes():
    qmlRegisterType(ModuleLoader, 'PicoWizard', 1, 0, 'ModuleLoader')


def __main__():
    QQuickStyle.setStyle("Material")

    app = QApplication(sys.argv)
    app.setApplicationName("pico-wizard")
    app.setApplicationDisplayName("Pico Wizard")

    registerTypes()
    ModuleLoader.registerModuleTypes()

    engine = QQmlApplicationEngine()
    engine.addImportPath(os.path.dirname(os.path.realpath(__file__)))
    engine.load(QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "start.qml")))

    if not engine.rootObjects():
        sys.exit(-1)

    signal.signal(signal.SIGINT, signal.SIG_DFL)

    sys.exit(app.exec_())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='pico-wizard', description='Pico Wizard')
    parser.add_argument('--debug', dest='debug', action='store_true', help='Enable debug mode')
    parser.set_defaults(debug=False)
    args = parser.parse_args()

    if args.debug:
        Logger.setLogMode(Logger.Mode.DEBUG)

    # Import ModuleLoader after setting debug mode
    from pico.moduleloader import ModuleLoader

    # execute only if run as the entry point into the program
    __main__()
