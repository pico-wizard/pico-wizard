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
                placeholderText: qsTr("Full Name")
            }

            PlasmaComponents.TextField {
                id: username
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: qsTr("Username")
            }

            PlasmaComponents.TextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: qsTr("Password")
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
            }

            PlasmaComponents.TextField {
                id: password
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                placeholderText: qsTr("Confirm Password")
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
            }

            /*Button {
                Layout.fillWidth: true
                text: qsTr("Create User")
                onClicked: {
                    userModule.createUser(username.text, password.text)
                }
            }*/
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
