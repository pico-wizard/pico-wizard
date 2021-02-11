import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.kirigami 2.7 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents

import PicoWizard 1.0

Module {
    id: root
    moduleIconColor: "#ff999999"

    delegate: Item {
        Rectangle {
            id: wifiContainer
            width: root.width * 0.7
            anchors {
                top: parent.top
                bottom: nextButton.top
                bottomMargin: 16
                horizontalCenter: parent.horizontalCenter
            }

            radius: 4
            border.width: 2
            border.color: "#fff0f0f0"
            color: "#fff5f5f5"

            ScrollIndicator {
                id: wifiScroll
                width: 12
                anchors {
                    top: wifiContainer.top
                    right: wifiContainer.right
                    bottom: wifiContainer.bottom
                }
            }

            ListView {
                id: wifiListView
                anchors.fill: parent
                anchors.margins: 16

                spacing: 4
                model: wifiModule.model
                clip: true
                ScrollIndicator.vertical: wifiScroll

                delegate: Rectangle {
                    width: parent ? parent.width : 0
                    height: 80

                    RowLayout {
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: 12
                        }

                        Kirigami.Icon {
                            Layout.leftMargin: 12
                            Layout.rightMargin: 12
                            width: 16
                            height: width
                            opacity: 0.7
                            source: wifiModule.getWifiIcon(signal)
                        }

                        ColumnLayout {

                            Label {
                                id: wifiName
                                text: qsTr(ssid)
                                font.pointSize: 10
                            }

                            Label {
                                text: qsTr(security)
                                color: "#aaaaaa"
                                font.pointSize: 7
                            }
                        }
                    }

                    Kirigami.Icon {
                        width: 28
                        height: 28
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            rightMargin: 12
                        }
                        source: wifiModule.dir() + "/assets/next.svg"
                        color: "#ffcccccc"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            wifiListView.currentIndex = index
                            passwordDialog.wifiName = wifiName.text
                            passwordDialog.open()
                            console.log("Connecting to wifi")
                        }
                    }
                }
            }
        }

        NextButton {
            id: nextButton

            onNextClicked: {
                accepted = true
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0
            }
        }

        Dialog {
            property string wifiName

            id: passwordDialog
            modal: true
            implicitWidth: 300
            z: 10

            font.pixelSize: 10

            x: (Screen.width - width) / 2
            y: (Screen.height - height) / 2

            footer: DialogButtonBox {
                Button {
                    flat: true
                    text: "Connect"
                    DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                    font.pixelSize: 10
                    font.bold: true
                    hoverEnabled: true
                    Material.foreground: Material.color(Material.Blue, Material.Shade500)
                    onClicked: {
                        wifiModule.setWifi(wifiListView.currentIndex, password.text)
                    }
                }
            }

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right

                Label {
                    text: `Connect to ${passwordDialog.wifiName}`
                    color: "#444444"
                    font.pointSize: 14
                    font.bold: true
                    topPadding: 16
                    bottomPadding: 16
                }

                PlasmaComponents.TextField {
                    id: password
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    Layout.topMargin: 16
                    passwordCharacter: "*"
                    revealPasswordButtonShown: true
                    echoMode: "Password"

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#f5f5f5"

                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            visible: password.text.length <= 0
                            text: qsTr("Password")
                            color: "#888888"
                        }
                    }
                    color: "#222222"
                    selectionColor: "#2196f3"
                    selectedTextColor: "#ffffff"
                }
            }
        }

        WifiModule {
            id: wifiModule

            function getWifiIcon(strength) {
                var icon = ""

                if (strength > 0 && strength < 25) {
                    icon = "signal-25.svg"
                } else if (strength >= 25 && strength < 50) {
                    icon = "signal-50.svg"
                } else if (strength >= 50 && strength < 75) {
                    icon = "signal-75.svg"
                } else if (strength >= 75) {
                    icon = "signal-100.svg"
                } else {
                    icon = "signal-0.svg"
                }

                return wifiModule.dir() + "/assets/" + icon
            }

            Component.onCompleted: {
                root.moduleName = wifiModule.moduleName()
                root.moduleIcon = wifiModule.dir() + "/assets/wifi.svg"
            }

            onConnectWifiSuccess: {
                nextButton.next()
            }

            onConnectWifiFailed: {
                nextButton.cancel()
            }
        }
    }
}
