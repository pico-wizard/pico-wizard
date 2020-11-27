import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import org.kde.kirigami 2.7 as Kirigami

RoundButton {
    width: 64
    height: 64

    flat: true
    onClicked: {
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
