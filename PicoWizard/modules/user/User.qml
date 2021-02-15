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
    hideSkip: true

    delegate: Item {
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * 0.7

            PlasmaComponents.TextField {
                id: fullname
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        visible: fullname.text.length <= 0
                        text: qsTr("Full Name")
                        color: "#888888"
                    }
                }
                color: "#222222"
                selectionColor: "#2196f3"
                selectedTextColor: "#ffffff"
            }

            PlasmaComponents.TextField {
                id: username
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        visible: username.text.length <= 0
                        text: qsTr("Username")
                        color: "#888888"
                    }
                }
                color: "#222222"
                selectionColor: "#2196f3"
                selectedTextColor: "#ffffff"
            }

            PlasmaComponents.TextField {
                id: password
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        visible: password.text.length <= 0
                        text: qsTr("Password")
                        color: "#888888"
                    }
                }
                color: "#222222"
                selectionColor: "#2196f3"
                selectedTextColor: "#ffffff"
            }

            PlasmaComponents.TextField {
                id: cnfPassword
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"
                    border.width: cnfPassword.text.length > 0 ? 1 : 0
                    border.color: cnfPassword.text !== password.text
                                    ? Material.color(Material.Red, Material.Shade500)
                                    : Material.color(Material.Green, Material.Shade500)

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        visible: cnfPassword.text.length <= 0
                        text: qsTr("Confirm Password")
                        color: "#888888"
                    }
                }
                color: "#222222"
                selectionColor: "#2196f3"
                selectedTextColor: "#ffffff"
            }
        }

        NextButton {
            id: nextButton
            enabled: fullname.text.length > 0 &&
                     username.text.length > 0 &&
                     cnfPassword.text.length > 0 &&
                     cnfPassword.text === password.text

            onNextClicked: {
                accepted = true
                userModule.createUser(fullname.text, username.text, cnfPassword.text)
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0
            }
        }

        UserModule {
            id: userModule

            Component.onCompleted: {
                root.moduleName = userModule.moduleName()
                root.moduleIcon = userModule.dir() + "/assets/user.svg"
            }

            property var signals: Connections {
                function onCreateUserSuccess() {
                    nextButton.next()
                }

                function onCreateUserFailed() {
                    nextButton.cancel()
                }

                function onErrorOccurred(err) {
                    toastManager.show(err, 2000)
                }
            }
        }
    }
}
