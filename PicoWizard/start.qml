// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0

ApplicationWindow {
    property alias moduleLoader: moduleLoader

    id: appRoot
    width: 500
    height: 800
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    visibility: Qt.AutomaticVisibility

//    onClosing: {
//        if (appStack.depth > 1) {
//            moduleLoader.back()
//            close.accepted = false
//        }
//    }

    visible: true

    ModuleLoader {
        id: moduleLoader

        function back() {
            moduleLoader.previousModule()
            appStack.pop()
        }
    }

    ToastManager {
        id: toastManager
    }

    Connections {
        target: moduleLoader

        function onLoadModule(url) {
            appStack.push("file:///" + url)
        }
    }

    Image {
        fillMode: Image.PreserveAspectFit
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        /* Background provided by loading.io */
        source: Qt.resolvedUrl("assets/background.svg")
    }

    StackView {
        property int animationDuration: 300
        property int easingType: Easing.InOutExpo

        id: appStack
        anchors.fill: parent
        initialItem: "file:///" + moduleLoader.welcomeModule()

        pushEnter: Transition {
            PropertyAnimation {
                property: "x"
                easing.type: appStack.easingType
                from: appStack.width
                to: 0
                duration: appStack.animationDuration
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "x"
                easing.type: appStack.easingType
                from: 0
                to: -appStack.width
                duration: appStack.animationDuration
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "x"
                easing.type: appStack.easingType
                from: -appStack.width
                to: 0
                duration: appStack.animationDuration
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "x"
                easing.type: appStack.easingType
                from: 0
                to: appStack.width
                duration: appStack.animationDuration
            }
        }
    }
}
