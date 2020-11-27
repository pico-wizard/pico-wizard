import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.kirigami 2.7 as Kirigami

import Pico 1.0
import ".."

Module {
    moduleName: simModule.moduleName()

    SimModule {
        id: simModule
    }

    RoundButton {
        width: 64
        height: 64

        anchors {
            horizontalCenter: labelWelcome.horizontalCenter
            top: labelWelcome.bottom
            topMargin: 48
        }
        flat: true
        onClicked: {
            moduleLoader.nextModule()
        }

        Material.background: Material.color(Material.Grey, Material.Shade100)
        Material.elevation: 0

        Kirigami.Icon {
            width: 24
            height: 24

            anchors.centerIn: parent
            source: "draw-arrow-forward"
            color: labelWelcome.color
        }
    }
}
