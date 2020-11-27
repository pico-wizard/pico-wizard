import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.7 as Kirigami

import Pico 1.0
import ".."

Item {
    WelcomeModule {
        id: welcomeModule
    }

    Label {
        id: labelWelcome
        font.weight: Font.Light
        font.pointSize: 32
        text: "Welcome"
        anchors.centerIn: parent
        color: "#444"
    }

    NextButton {
//        anchors {
//            horizontalCenter: labelWelcome.horizontalCenter
//            top: labelWelcome.bottom
//            topMargin: 48
//        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 16
        }
    }
}
