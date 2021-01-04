import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15
import QtGraphicalEffects 1.0

import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0

Item {
    property alias moduleName: labelModuleName.text
    property alias moduleIcon: icon.source
    property alias moduleIconColor: colorOverlay.color
    property alias delegate: delegateLoader.sourceComponent

    RoundButton {
        width: Kirigami.Settings.isMobile ? 40 : 48
        height: Kirigami.Settings.isMobile ? 40 : 48

        anchors {
            right: labelModuleName.left
            rightMargin: 4
            verticalCenter: labelModuleName.verticalCenter
        }
        flat: true
        onClicked: {
            moduleLoader.back()
        }
        visible: moduleLoader.hasPrevious
        z: 100

        Kirigami.Icon {
            anchors.fill: parent
            anchors.centerIn: parent
            source: Qt.resolvedUrl("./assets/back.svg")
            color: "#ffffffff"
            anchors.margins: 12
        }
    }

    Label {
        id: labelModuleName
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: Kirigami.Settings.isMobile ? 40 : 56
            topMargin: Kirigami.Settings.isMobile ? 14 : 56
        }
        font.weight: Font.Light
        font.pointSize: Kirigami.Settings.isMobile ? 16 : 24
        color: "#fff5f5f5"
    }

    Label {
        anchors {
            right: parent.right
            top: parent.top
            rightMargin: Kirigami.Settings.isMobile ? 40 : 56
            topMargin: Kirigami.Settings.isMobile ? 14 : 56
        }
        font.weight: Font.Light
        font.pointSize: Kirigami.Settings.isMobile ? 16 : 24
        color: "#fff5f5f5"
        text: qsTr("Skip")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                moduleLoader.nextModule()
            }
        }
    }

    Pane {
        id: control
        anchors {
            fill: parent
            leftMargin: Kirigami.Settings.isMobile ? 12 : 56
            rightMargin: Kirigami.Settings.isMobile ? 12 : 56
            topMargin: Kirigami.Settings.isMobile ? 48 : 112
        }
        background: Rectangle {
            color: control.Material.backgroundColor
            radius: 4

            layer.enabled: true
            layer.effect: ElevationEffect {
                elevation: control.Material.elevation
            }
        }
        Material.elevation: 6

        ColumnLayout {
            anchors.fill: parent

            Kirigami.Icon {
                id: icon

                Layout.preferredWidth: Kirigami.Settings.isMobile ? 64 : 196
                Layout.preferredHeight: Kirigami.Settings.isMobile ? 64 : 196
                Layout.alignment: Layout.Center
                Layout.topMargin: Kirigami.Settings.isMobile ? 24 : 64
                Layout.bottomMargin: Kirigami.Settings.isMobile ? 24 : 64

                ColorOverlay {
                    id: colorOverlay

                    anchors.fill: parent
                    source: parent
                }
            }

            Loader {
                id: delegateLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
