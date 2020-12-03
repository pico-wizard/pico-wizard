import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0

Module {
    id: root
    moduleName: userModule.moduleName()
    moduleIcon: userModule.dir() + "/assets/user.svg"
    moduleIconColor: "#ff999999"

    delegate: Item {
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * 0.5

            PlasmaComponents.TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: "Full Name"
            }

            PlasmaComponents.TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: "Username"
            }

            PlasmaComponents.TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: "Password"
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
            }

            PlasmaComponents.TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: "Confirm Password"
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
            }
        }

        NextButton {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 16
            }
        }
    }

    UserModule {
        id: userModule
    }
}
