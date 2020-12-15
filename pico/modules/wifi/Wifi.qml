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
    moduleName: wifiModule.moduleName()
    moduleIcon: wifiModule.dir() + "/assets/wifi.svg"
    moduleIconColor: "#ff999999"

    delegate: Item {
        Rectangle {
            id: wifiContainer
            width: root.width * 0.6
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
                anchors.fill: parent
                anchors.margins: 16

                spacing: 4
                model: [0, 1, 2, 3, 4, 5]
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
                            source: wifiModule.getWifiIcon(Math.floor(Math.random() * 100))
                        }

                        ColumnLayout {

                            Label {
                                id: wifiName
                                text: qsTr("Tp Link 92B3")
                                font.pointSize: 12
                            }

                            Label {
                                text: qsTr("WPA / WPA2")
                                color: "#aaaaaa"
                                font.pointSize: 8
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
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 16
            }
        }
    }

    Dialog {
        property string wifiName

        id: passwordDialog
        modal: true
        implicitWidth: 400
        z: 10

        font.pixelSize: 10

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        footer: DialogButtonBox {
            Button {
                flat: true
                text: "Connect"
                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                font.pixelSize: 10
                font.bold: true
                hoverEnabled: true
                Material.foreground: Material.color(Material.Blue, Material.Shade500)
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
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.topMargin: 16
                placeholderText: qsTr("Password")
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
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
    }
}
