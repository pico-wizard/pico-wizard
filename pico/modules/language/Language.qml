import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.kirigami 2.7 as Kirigami

import Pico 1.0
import ".."

Module {
    id: root
    moduleName: languageModule.moduleName()

    LanguageModule {
        id: languageModule
    }

    RowLayout {
        anchors.centerIn: parent

        Kirigami.Icon {
            width: 56
            height: 56

            source: "input-keyboard"
        }

        ComboBox {
            Layout.minimumWidth: root.width * 0.3
            Layout.maximumWidth: root.width * 0.3
            model: [1, 2, 3, 4, 5]
        }
    }

    RoundButton {
        width: 64
        height: 64

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 96
        }
        flat: true
        onClicked: {
            console.log(root.width)
            moduleLoader.nextModule()
        }

        Material.background: Material.color(Material.Blue, Material.Shade500)
        Material.elevation: 0

        Kirigami.Icon {
            width: 24
            height: 24

            anchors.centerIn: parent
            source: "draw-arrow-forward"
            color: "#ffffffff"
        }
    }
}
