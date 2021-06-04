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
    property alias moduleName: labelModuleName.text
    property alias moduleIcon: icon.source
    property alias moduleIconColor: icon.color
    property alias delegate: delegateLoader.sourceComponent
    property bool hideSkip: false

    RoundButton {
        width: Kirigami.Settings.isMobile ? 40 : 48
        height: Kirigami.Settings.isMobile ? 40 : 48
        hoverEnabled: false

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

        background: Rectangle {
            color: "transparent"
        }

        Kirigami.Icon {
            anchors.fill: parent
            anchors.centerIn: parent
            source: Qt.resolvedUrl("./assets/back.svg")
            anchors.margins: 12
            color: "#ffffffff"
            isMask: true
        }
    }

    Label {
        id: labelModuleName
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: Kirigami.Settings.isMobile ? 54 : 56
            topMargin: Kirigami.Settings.isMobile ? 32 : 56
        }
        font.weight: Font.Light
        font.pointSize: Kirigami.Settings.isMobile ? 16 : 24
        color: "#fff5f5f5"
    }

    Label {
        id: labelSkip
        anchors {
            right: parent.right
            top: parent.top
            rightMargin: Kirigami.Settings.isMobile ? 40 : 56
            topMargin: Kirigami.Settings.isMobile ? 32 : 56
        }
        font.weight: Font.Light
        font.pointSize: Kirigami.Settings.isMobile ? 16 : 24
        color: "#fff5f5f5"
        text: qsTr("Skip")
        visible: !hideSkip

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
            leftMargin: Kirigami.Settings.isMobile ? 24 : 56
            rightMargin: Kirigami.Settings.isMobile ? 24 : 56
            topMargin: Kirigami.Settings.isMobile ? 64 : 112
        }
        background: Rectangle {
            color: Kirigami.Theme.backgroundColor
            radius: 4
            border.width: 1
            border.color: "#ffdfdfdf"
        }

        ColumnLayout {
            anchors.fill: parent

            Kirigami.Icon {
                id: icon
                isMask: true

                Layout.preferredWidth: Kirigami.Settings.isMobile ? 64 : 196
                Layout.preferredHeight: Kirigami.Settings.isMobile ? 64 : 196
                Layout.alignment: Layout.Center
                Layout.topMargin: Kirigami.Settings.isMobile ? 24 : 64
                Layout.bottomMargin: Kirigami.Settings.isMobile ? 24 : 64
            }

            Loader {
                id: delegateLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
