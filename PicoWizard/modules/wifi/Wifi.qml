// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Window 2.15
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
        id: delegateRoot

        Rectangle {
            id: wifiContainer
            width: root.width * 0.7
            anchors {
                top: parent.top
                bottom: parent.bottom
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
                anchors.margins: 8

                spacing: 4
                model: wifiModule.model
                clip: true
                ScrollIndicator.vertical: wifiScroll

                delegate: Rectangle {
                    width: parent ? parent.width : 0
                    height: 50

                    RowLayout {
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: 12
                        }

                        Kirigami.Icon {
                            Layout.leftMargin: 0
                            Layout.rightMargin: 4
                            Layout.preferredWidth: 24
                            Layout.preferredHeight: 24
                            opacity: 0.7
                            source: wifiModule.getWifiIcon(signal)
                        }

                        ColumnLayout {
                            Label {
                                id: wifiName
                                text: trimName(ssid)
                                font.pointSize: 10

                                function trimName(name) {
                                    if (name.length > 18) {
                                        return name.slice(0, 18) + "..."
                                    } else {
                                        return name
                                    }
                                }
                            }

                            RowLayout {
                                Kirigami.Icon {
                                    visible: isSecured
                                    opacity: 0.7
                                    Layout.leftMargin: 0
                                    Layout.rightMargin: 0
                                    Layout.preferredWidth: 10
                                    Layout.preferredHeight: 10
                                    source: wifiModule.dir() + "/assets/lock.svg"
                                }

                                Label {
                                    text: security
                                    color: "#aaaaaa"
                                    font.pointSize: 7
                                }
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
                            if (security) {
                                wifiListView.currentIndex = index
                                passwordDialog.wifiName = wifiName.text
                                password.text = ""
                                passwordDialog.open()
                            } else {
                                wifiModule.setWifi(index, '')
                                connectingPopup.open()
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                anchors.centerIn: wifiListView
                Layout.alignment: Qt.AlignHCenter|Qt.AlignVCenter
                spacing: 12
                visible: wifiListView.count <= 0

                Kirigami.Icon {
                    width: 18
                    height: 18
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignVCenter

                    source: wifiModule.dir() + "/assets/spinner.svg"
                    color: "#ff666666"
                    opacity: 0.5

                    RotationAnimation on rotation {
                        loops: Animation.Infinite
                        from: -90
                        to: 270
                        duration: 500
                        running: true
                    }
                }

                Label {
                    font.italic: true
                    text: qsTr("Listing Wifi Connections")
                    color: "#ff666666"
                    opacity: 0.5
                }
            }
        }

        Dialog {
            property string wifiName

            id: passwordDialog
            modal: true
            implicitWidth: 300
            z: 10

            font.pixelSize: 10

            parent: Overlay.overlay

            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)

            footer: DialogButtonBox {
                Button {
                    enabled: password.text.length > 0
                    flat: true
                    text: "Connect"
                    DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                    font.pixelSize: 10
                    font.bold: true
                    hoverEnabled: true
                    Material.foreground: Material.color(Material.Blue, Material.Shade500)
                    onClicked: {
                        wifiModule.setWifi(wifiListView.currentIndex, password.text)
                        connectingPopup.open()
                    }
                }
            }

            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right

                Label {
                    text: `Connect to ${trimName(passwordDialog.wifiName)}`
                    color: "#444444"
                    font.pointSize: 11
                    font.bold: true
                    topPadding: 8
                    bottomPadding: 8

                    function trimName(name) {
                        if (name.length > 15) {
                            return name.slice(0, 15) + "..."
                        } else {
                            return name
                        }
                    }
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

        Popup {
            id: connectingPopup
            modal: true
            implicitWidth: 300
            z: 10
            closePolicy: Popup.NoAutoClose

            font.pixelSize: 11

            parent: Overlay.overlay

            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)

            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 12

                Kirigami.Icon {
                    width: 18
                    height: 18

                    source: wifiModule.dir() + "/assets/spinner.svg"
                    color: "#ff666666"
                    opacity: 0.5

                    RotationAnimation on rotation {
                        loops: Animation.Infinite
                        from: -90
                        to: 270
                        duration: 500
                        running: true
                    }
                }

                Label {
                    text: qsTr("Connecting")
                    color: "#ff444444"
                    opacity: 0.5
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

            property var signals: Connections {
                function onConnectWifiSuccess() {
                    connectingPopup.close()
                    moduleLoader.nextModule()
                }

                function onConnectWifiFailed() {
                    connectingPopup.close()
                }

                function onErrorOccurred(err) {
                    toastManager.show(err, 2000)
                }
            }
        }
    }
}
