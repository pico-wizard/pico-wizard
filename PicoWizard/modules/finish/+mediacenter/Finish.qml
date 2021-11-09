// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
// SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0


import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0


FocusScope {
    property bool runningFinishHook: false

    Component.onCompleted: {
        welcomeQMLPage.forceActiveFocus()
    }

    FinishModule {
        id: finishModule

        Component.onCompleted: {
            finishModule.runScripts()
        }
    }

    ColumnLayout {
        visible: !finishModule.isComplete
        anchors.centerIn: parent

        Label {
            font.weight: Font.Light
            font.pointSize: 32
            text: qsTr("Finalizing")
            color: Kirigami.Theme.textColor
        }

        Label {
            visible: finishModule.totalScriptsCount > 0
            Layout.topMargin: 48
            Layout.alignment: Qt.AlignHCenter
            font.weight: Font.Light
            font.pointSize: 10
            text: qsTr(`Running Script [${finishModule.runningScriptIndex + 1}/${finishModule.totalScriptsCount}]`)
            color: Kirigami.Theme.textColor
        }
    }

    Label {
        visible: finishModule.isComplete
        font.weight: Font.Light
        font.pointSize: 32
        text: qsTr("Setup Complete")
        anchors.centerIn: parent
        color: Kirigami.Theme.textColor
    }

    Button {
        id: finishBtn
        width: Kirigami.Units.gridUnit * 4
        height: Kirigami.Units.gridUnit * 3
        focus: true

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Kirigami.Units.gridUnit * 6
        }
        flat: true

        Keys.onReturnPressed: clicked()

        onClicked: {
            if (finishModule.isComplete) {
                runningFinishHook = true
                finishModule.runCompleteHook()
            }
        }

        background: Rectangle {
            color: finishModule.isComplete ? "#ff4caf50" : "#f5f5f5"
            radius: 2
            border.width: 1
            border.color: finishBtn.activeFocus ? Kirigami.Theme.highlightColor : "transparent"
        }

        Kirigami.Icon {
            visible: finishModule.isComplete && !runningFinishHook
            width: 24
            height: 24
            color: "#ffffffff"
            isMask: true

            anchors.centerIn: parent
            source: finishModule.dir() + "/assets/done.svg"
        }

        Kirigami.Icon {
            anchors.centerIn: parent
            visible: !finishModule.isComplete || runningFinishHook
            width: 24
            height: 24
            Layout.alignment: Qt.AlignHCenter
            color: "#ff444444"
            isMask: true

            source: finishModule.dir() + "/assets/spinner.svg"

            RotationAnimation on rotation {
                loops: Animation.Infinite
                from: -90
                to: 270
                duration: 500
                running: true
            }
        }
    }

    RowLayout {
        anchors.top: finishBtn.bottom
        anchors.topMargin: Kirigami.Units.gridUnit
        anchors.horizontalCenter: parent.horizontalCenter

        Kirigami.Icon {
            source: finishModule.dir() + "/assets/remote.svg"
            width: 24
            height: 24
        }

        Label {
            id: labelButtonInfo
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Light
            minimumPointSize: 5
            font.pointSize: 20
            maximumLineCount: 1
            fontSizeMode: Text.Fit
            wrapMode: Text.WordWrap
            text: qsTr("Press Select Button To Continue!")
            color: Kirigami.Theme.textColor
        }
    }
}
