import os

from PySide2.QtCore import QUrl, Slot, Signal, Property, QObject, QProcess
from PySide2.QtQml import qmlRegisterType

from pico.module import Module
from pico.modules.wifi.wifimodel import WifiModel
from pico.utils.logger import Logger


class Wifi(Module):
    log = Logger.getLogger(__name__)

    def __init__(self, parent=None):
        super().__init__(__file__, parent)

        self.listWifiProcess = QProcess(self)
        self._wifiModel = WifiModel(parent)

        self.listWifi()

    @staticmethod
    def registerTypes() -> None:
        qmlRegisterType(Wifi, 'PicoWizard', 1, 0, 'WifiModule')

    @staticmethod
    def qmlPath() -> QUrl:
        return QUrl(os.path.join(os.path.dirname(os.path.realpath(__file__)), "Wifi.qml"))

    @Slot(None, result=str)
    def moduleName(self) -> str:
        return self.tr("Wifi")

    @Signal
    def modelChanged(self):
        pass

    @Property(QObject, notify=modelChanged)
    def model(self):
        return self._wifiModel

    def listWifi(self):
        self.log.info('Fetching list of wifi')

        args = [
            '-c',
            'no',
            '-f',
            'SSID,SIGNAL,SECURITY',
            '-t',
            'dev',
            'wifi',
            'list',
            '--rescan',
            'yes'
        ]

        self.listWifiProcess.start('nmcli', args)

        self.listWifiProcess.finished.connect(lambda exitCode, exitStatus: self.listWifiProcessFinished(exitCode, exitStatus))
        self.listWifiProcess.errorOccurred.connect(lambda err: self.listWifiProcessError(err))

    def listWifiProcessFinished(self, exitCode, exitStatus):
        self.log.debug(f'List Wifi process status : {exitStatus}[CODE {exitCode}]')
        self.log.info('Listing Wifi')

        if exitCode != 0:
            self.log.error(f'Failed to get wifi list : {exitStatus}')
        else:
            self.log.debug('Parsing wifi data')
            self.generateWifiList(self.listWifiProcess.readAll().data().decode())

    def listWifiProcessError(self, err):
        self.log.error(f'Failed to get wifi list : {err}')

    def generateWifiList(self, output):
        index = 0

        self.log.debug(f'Wifi output : {output}')

        for item in output.splitlines():
            item_arr = item.split(":")

            if item_arr[0]:
                wifiItem = {
                    'ssid': item_arr[0],
                    'signal': item_arr[1],
                    'security': item_arr[2]
                }

                self._wifiModel.layoutAboutToBeChanged.emit()
                self._wifiModel.addWifiItem(wifiItem)
                self._wifiModel.layoutChanged.emit()

        self.log.info('Generated Wifi List')
        self.log.debug(self._wifiModel.getWifiList())

    @Slot(int, str, result=None)
    def setWifi(self, wifiIndex, password):
        ssid = self._wifiModel.data(self._wifiModel.index(wifiIndex, 0), WifiModel.SsidRole)
        self.log.debug(f'Selected SSID : {ssid}')

        process = QProcess(self)
        args = [
            'dev',
            'wifi',
            'connect',
            ssid,
            'password',
            password
        ]

        process.start('nmcli', args)

        process.finished.connect(lambda exitCode, exitStatus: self.wifiCmdSuccess(exitCode, exitStatus))
        process.error.connect(lambda err: self.wifiCmdFailed(err))

    def wifiCmdSuccess(self, exitCode, exitStatus):
        self.log.debug(f'Connect Wifi process status : {exitStatus} [CODE {exitCode}]')
        self.log.info('Connecting to Wifi')

        if exitCode != 0:
            self.log.error(f'Failed to connect to wifi : {exitStatus}')
            self.connectWifiFailed.emit()
        else:
            self.connectWifiSuccess.emit()

    def wifiCmdFailed(self, err):
        self.log.error(f'Failed to connect to wifi : {err}')
        self.connectWifiFailed.emit()

    @Signal
    def connectWifiSuccess(self):
        pass

    @Signal
    def connectWifiFailed(self):
        pass
