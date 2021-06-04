// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0


import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0


Item {
    property bool runningFinishHook: false

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
            color: "#444"
        }

        Label {
            visible: finishModule.totalScriptsCount > 0
            Layout.topMargin: 48
            Layout.alignment: Qt.AlignHCenter
            font.weight: Font.Light
            font.pointSize: 10
            text: qsTr(`Running Script [${finishModule.runningScriptIndex + 1}/${finishModule.totalScriptsCount}]`)
            color: "#888888"
        }
    }

    Label {
        visible: finishModule.isComplete
        font.weight: Font.Light
        font.pointSize: 32
        text: qsTr("Setup complete")
        anchors.centerIn: parent
        color: "#444"
    }

    RoundButton {
        width: 64
        height: 64

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 12
        }
        flat: true
        onClicked: {
            if (finishModule.isComplete) {
                runningFinishHook = true
                finishModule.runCompleteHook()
            }
        }

        background: Rectangle {
            color: finishModule.isComplete ? "#ff4caf50" : "#f5f5f5"
            radius: parent.width
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
}
