// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
// SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.9 as Kirigami

import PicoWizard 1.0

FocusScope {
    id: welcomeQMLPage

    WelcomeModule {
        id: welcomeModule
    }

    Component.onCompleted: {
        parent.backgroundSource = Qt.resolvedUrl("../../assets/background-mediacenter.svg")
        welcomeQMLPage.forceActiveFocus()
    }

    KeyNavigation.down: nextBtn

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                id: labelWelcome
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Light
                minimumPixelSize: 2
                font.pixelSize: 72
                maximumLineCount: 3
                fontSizeMode: Text.Fit
                wrapMode: Text.WordWrap
                text: qsTr("<font color=\"#1e88e5\"><b>Hello</b></font> Plasma Bigscreen")
                color: Kirigami.Theme.textColor
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.25
            Layout.alignment: Qt.AlignHCenter

            RoundButton {
                id: nextBtn
                focus: true
                width: parent.height * 0.6
                height: width
                anchors.centerIn: parent

                background: Rectangle {
                    color: nextBtn.activeFocus ? Kirigami.Theme.backgroundColor : Qt.lighter(Kirigami.Theme.backgroundColor, 1.2)
                    border.color: nextBtn.activeFocus ? Kirigami.Theme.highlightColor : Qt.lighter(Kirigami.Theme.backgroundColor, 1.2)
                    border.width: nextBtn.activeFocus ? 4 : 0
                    radius: parent.width
                }

                contentItem: Item {
                    Kirigami.Icon {
                        id: nextIcon
                        width: parent.width * 0.9
                        height: width
                        color: "#ffffffff"
                        isMask: true

                        anchors.centerIn: parent
                        source: welcomeModule.dir() + "/assets/next.svg"
                    }
                }

                Keys.onReturnPressed: {
                    moduleLoader.nextModule()
                }

                onClicked: {
                    moduleLoader.nextModule()
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter

            Kirigami.Icon {
                source: welcomeModule.dir() + "/assets/remote.svg"
                width: 24
                height: 24
            }

            Label {
                id: labelButtonInfo
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Light
                minimumPixelSize: 2
                font.pixelSize: 25
                maximumLineCount: 2
                fontSizeMode: Text.Fit
                wrapMode: Text.WordWrap
                text: qsTr("Press Select Button To Continue!")
                color: Kirigami.Theme.textColor
            }
        }
    }
}
