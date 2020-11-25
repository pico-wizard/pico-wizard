import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10

import Pico 1.0

Item {
    anchors.fill: parent

    WelcomeModule {
        id: welcomeModule
    }

    Rectangle {
        anchors.fill: parent
        color: "#444444"

        Button {
            anchors.centerIn: parent
            text: "Click Me"

            onClicked: {
                appRoot.nextModule()
            }
        }
    }
}