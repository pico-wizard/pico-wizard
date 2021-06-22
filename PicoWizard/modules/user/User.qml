// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0

Module {
    property var digitValidator: RegExpValidator { regExp: /[0-9]*/ }
    property var alphaNumericValidator: RegExpValidator { regExp: /.*/ }

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
                    border.width: 1
                    border.color: Material.color(Material.Grey, Material.Shade300)

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
                validator: RegExpValidator { regExp: /[a-z_][a-z0-9_-]*[$]?/ }
                maximumLength: 32
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"
                    border.width: 1
                    border.color: Material.color(Material.Grey, Material.Shade300)

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

                Popup {
                    id: usernamePopup
                    y: -(height+5)
                    width: parent.width
                    visible: username.focus

                    closePolicy: Popup.CloseOnPressOutsideParent
                    Material.elevation: 0

                    background: Rectangle {
                        radius: 2
                        color: Material.color(Material.Grey, Material.Shade900)
                    }

                    ColumnLayout {
                        anchors.fill: parent

                        Label {
                            text: "- Should be lowercase"
                            color: "white"
                        }
                        Label {
                            text: "- Should start with [a-z] or '_'"
                            color: "white"
                        }
                        Label {
                            text: "- Can contain [a-z], [0-9], '_', and '-'"
                            color: "white"
                        }
                        Label {
                            text: "- May end with a '$'"
                            color: "white"
                        }
                    }
                }
            }

            PlasmaComponents.TextField {
                id: password
                validator: {
                    if (userModule.passwordType === 'digitsonly')
                        return digitValidator
                    else if (userModule.passwordType === 'alphanumeric')
                        return alphaNumericValidator
                }

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"
                    border.width: 1
                    border.color: Material.color(Material.Grey, Material.Shade300)

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

                Popup {
                    y: -(height+5)
                    width: parent.width
                    visible: password.focus && userModule.passwordType === 'digitsonly'
                    closePolicy: Popup.CloseOnPressOutsideParent
                    Material.elevation: 0

                    background: Rectangle {
                        radius: 2
                        color: Material.color(Material.Grey, Material.Shade900)
                    }

                    ColumnLayout {
                        anchors.fill: parent

                        Label {
                            text: "- Should be digits only [0-9]"
                            color: "white"
                        }
                    }
                }
            }

            PlasmaComponents.TextField {
                id: cnfPassword
                validator: {
                    if (userModule.passwordType === 'digitsonly')
                        return digitValidator
                    else if (userModule.passwordType === 'alphanumeric')
                        return alphaNumericValidator
                }

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"
                    border.width: 1
                    border.color: cnfPassword.text.length > 0
                                    ? cnfPassword.text !== password.text
                                        ? Material.color(Material.Red, Material.Shade500)
                                        : Material.color(Material.Green, Material.Shade500)
                                    : Material.color(Material.Grey, Material.Shade300)

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
