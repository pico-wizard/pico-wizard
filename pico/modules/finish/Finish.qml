import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0


Item {
    FinishModule {
        id: finishModule
    }

    Label {
        id: labelComplete
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
            bottomMargin: 16
        }
        flat: true
        onClicked: {
            Qt.quit()
        }

        Material.background: Material.color(Material.Green, Material.Shade500)
        Material.elevation: 0

        Kirigami.Icon {
            width: 24
            height: 24

            anchors.centerIn: parent
            source: finishModule.dir() + "/assets/done.svg"
            color: "#ffffffff"
        }
    }
}
