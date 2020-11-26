import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.7 as Kirigami

import Pico 1.0

Item {
    WelcomeModule {
        id: welcomeModule
    }

    Image {
        fillMode: Image.PreserveAspectCrop
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
            topMargin: -24
        }

        source: welcomeModule.dir() + "/assets/background-top.svg"
    }

    Button {
        anchors.bottom:parent.bottom
        anchors.horizontalCenter: parent
        text: "Click Me"

        onClicked: {
//            moduleLoader.nextModule()
        }
    }


    Image {
        fillMode: Image.PreserveAspectCrop

        anchors {
            left: parent.left
            bottom: parent.bottom
            right: parent.right
            bottomMargin: -24
        }

        source: welcomeModule.dir() + "/assets/background-bottom.svg"
    }
}
