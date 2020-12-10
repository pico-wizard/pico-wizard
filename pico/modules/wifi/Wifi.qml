import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.kirigami 2.7 as Kirigami

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

                    RoundButton {
                        width: 32
                        height: 32
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            rightMargin: 12
                        }
                        flat: true
                        Material.elevation: 2

                        Kirigami.Icon {
                            anchors.fill: parent
                            source: "draw-arrow-forward"
                            color: "#ffcccccc"
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

    WifiModule {
        id: wifiModule

        function getWifiIcon(strength) {
            if (strength < 10) {
                return "network-wireless-signal-none"
            } else if (strength >= 10 && strength < 30) {
                return "network-wireless-signal-weak"
            } else if (strength >= 30 && strength < 50) {
                return "network-wireless-signal-ok"
            } else if (strength >= 50 && strength < 75) {
                return "network-wireless-signal-good"
            } else if (strength >= 75) {
                return "network-wireless-signal-excellent"
            }
        }
    }
}
