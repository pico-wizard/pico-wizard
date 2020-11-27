import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

import Pico 1.0

ApplicationWindow {
    property alias moduleLoader: moduleLoader

    id: appRoot

    ///////////////////
    // DEVELOPMENT
    ///////////////////
    width: 700
    height: 900
    x: 1920-500
    ///////////////////

    visible: true

//    header: Rectangle {
//        width: parent.width
//        height: 40
//        color: "#ffffff"

//        RowLayout {
//            Button {
//                text: "->"
//                enabled: moduleLoader.hasNext
//                onClicked: {
//                    moduleLoader.nextModule()
//                }
//            }
//        }
//    }

    ModuleLoader {
        id: moduleLoader
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
