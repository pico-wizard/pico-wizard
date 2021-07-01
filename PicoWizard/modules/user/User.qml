// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kirigami 2.9 as Kirigami

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
                topPadding: 16
                bottomPadding: 16

                placeholderText: qsTr("Full Name")
            }

            PlasmaComponents.TextField {
                id: username
                validator: RegExpValidator { regExp: /[a-z_][a-z0-9_-]*[$]?/ }
                maximumLength: 32
                Layout.fillWidth: true
                topPadding: 16
                bottomPadding: 16

                placeholderText: qsTr("Username")

                Popup {
                    id: usernamePopup
                    y: -(height+5)
                    width: parent.width
                    visible: username.focus

                    closePolicy: Popup.CloseOnPressOutsideParent

                    background: Rectangle {
                        radius: 2
                        color: "#ff212121"
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
                topPadding: 16
                bottomPadding: 16
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
                placeholderText: qsTr("Password")

                Popup {
                    y: -(height+5)
                    width: parent.width
                    visible: password.focus && userModule.passwordType === 'digitsonly'
                    closePolicy: Popup.CloseOnPressOutsideParent

                    background: Rectangle {
                        radius: 2
                        color: "#ff212121"
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
                topPadding: 16
                bottomPadding: 16
                passwordCharacter: "*"
                revealPasswordButtonShown: true
                echoMode: "Password"
                placeholderText: qsTr("Confirm Password")

//                    border.color: cnfPassword.text.length > 0
//                                  ? cnfPassword.text !== password.text
//                                      ? Kirigami.Theme.negativeTextColor
//                                      : Kirigami.Theme.positiveTextColor
//                                  : "#ffbdbdbd"
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
