// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
// SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
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

    Label {
        id: labelWelcome
        width: parent.width
        height: parent.height / 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.Light
        minimumPointSize: 5
        font.pointSize: 48
        maximumLineCount: 3
        fontSizeMode: Text.Fit
        wrapMode: Text.WordWrap
        text: qsTr("<font color=\"#1e88e5\"><b>Hello</b></font> Plasma Bigscreen")
        anchors.centerIn: parent
        color: Kirigami.Theme.textColor
    }

    NextButton {
        id: nextBtn
        focus: true
        background: Rectangle {
            color: nextBtn.activeFocus ? Kirigami.Theme.backgroundColor : Qt.lighter(Kirigami.Theme.backgroundColor, 1.2)
            border.color: nextBtn.activeFocus ? Kirigami.Theme.highlightColor : Qt.lighter(Kirigami.Theme.backgroundColor, 1.2)
            border.width: nextBtn.activeFocus ? 1 : 0
            radius: parent.width
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Kirigami.Units.gridUnit * 6
        }
    }
    RowLayout {
        anchors.top: nextBtn.bottom
        anchors.topMargin: Kirigami.Units.gridUnit
        anchors.horizontalCenter: parent.horizontalCenter

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
