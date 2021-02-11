import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0


Item {
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
            bottomMargin: 8
        }
        flat: true
        onClicked: {
            if (finishModule.isComplete) {
                Qt.quit()
            }
        }

        Material.background: finishModule.isComplete ? Material.color(Material.Green, Material.Shade500) : Material.color(Material.Grey, Material.Shade100)
        Material.elevation: 0

        Kirigami.Icon {
            visible: finishModule.isComplete
            width: 24
            height: 24

            anchors.centerIn: parent
            source: finishModule.dir() + "/assets/done.svg"
            color: "#ffffffff"
        }

        Kirigami.Icon {
            anchors.centerIn: parent
            visible: !finishModule.isComplete
            width: 24
            height: 24
            Layout.alignment: Qt.AlignHCenter

            source: finishModule.dir() + "/assets/spinner.svg"
            color: "#ff444444"

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
