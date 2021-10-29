// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
// SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kirigami 2.9 as Kirigami

import PicoWizard 1.0

ModuleMediaCenter {
    property var digitValidator: RegExpValidator { regExp: /[0-9]*/ }
    property var alphaNumericValidator: RegExpValidator { regExp: /.*/ }

    id: root
    moduleName: userModule.moduleName()
    moduleIcon: userModule.dir() + "/assets/user.svg"
    moduleIconColor: "#ff999999"
    hideSkip: true

    delegate: Item {

        Component.onCompleted: {
            fullNameContainer.forceActiveFocus()
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * 0.7

            Rectangle {
                id: fullNameContainer
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                border.color: fullNameContainer.activeFocus ? Kirigami.Theme.highlightColor : "transparent"
                border.width: fullNameContainer.activeFocus ? 1 : 0

                Keys.onReturnPressed: fullname.forceActiveFocus()
                KeyNavigation.down: userNameContainer
                KeyNavigation.up: nextButton.enabled ? nextButton : backButton

                PlasmaComponents.TextField {
                    id: fullname
                    anchors.fill: parent
                    placeholderText: qsTr("Full Name")
                    topPadding: 16
                    bottomPadding: 16
                }
            }

            Rectangle {
                id: userNameContainer
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                border.color: userNameContainer.activeFocus ? Kirigami.Theme.highlightColor : "transparent"
                border.width: userNameContainer.activeFocus ? 1 : 0

                Keys.onReturnPressed: username.forceActiveFocus()
                KeyNavigation.up: fullNameContainer
                KeyNavigation.down: passwordContainer

                PlasmaComponents.TextField {
                    id: username
                    validator: RegExpValidator { regExp: /[a-z_][a-z0-9_-]*[$]?/ }
                    maximumLength: 32
                    anchors.fill: parent
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
            }

            Rectangle {
                id: passwordContainer
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                border.color: passwordContainer.activeFocus ? Kirigami.Theme.highlightColor : "transparent"
                border.width: passwordContainer.activeFocus ? 1 : 0

                Keys.onReturnPressed: password.forceActiveFocus()
                KeyNavigation.up: userNameContainer
                KeyNavigation.down: cnfPasswordContainer

                PlasmaComponents.TextField {
                    id: password
                    validator: {
                        if (userModule.passwordType === 'digitsonly')
                            return digitValidator
                        else if (userModule.passwordType === 'alphanumeric')
                            return alphaNumericValidator
                    }

                    anchors.fill: parent
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
            }

            Rectangle {
                id: cnfPasswordContainer
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                border.color: cnfPasswordContainer.activeFocus ? Kirigami.Theme.highlightColor : "transparent"
                border.width: cnfPasswordContainer.activeFocus ? 1 : 0

                Keys.onReturnPressed: cnfPassword.forceActiveFocus()
                KeyNavigation.up: passwordContainer
                KeyNavigation.down: nextButton.enabled ? nextButton : backButton

                PlasmaComponents.TextField {
                    id: cnfPassword
                    validator: {
                        if (userModule.passwordType === 'digitsonly')
                            return digitValidator
                        else if (userModule.passwordType === 'alphanumeric')
                            return alphaNumericValidator
                    }

                    anchors.fill: parent
                    topPadding: 16
                    bottomPadding: 16
                    passwordCharacter: "*"
                    revealPasswordButtonShown: true
                    echoMode: "Password"
                    placeholderText: qsTr("Confirm Password")
                }
            }
        }

        RowLayout {
            width: root.width * 0.7
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0
            }

            Button {
                id: backButton
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3

                KeyNavigation.right: nextButton

                icon.name: "go-previous"
                text: "Back"

                Keys.onReturnPressed: clicked()

                onClicked: {
                    moduleLoader.back()
                }
                visible: moduleLoader.hasPrevious
            }

            NextButtonMediaCenter {
                id: nextButton
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3

                enabled: fullname.text.length > 0 &&
                     username.text.length > 0 &&
                     cnfPassword.text.length > 0 &&
                     cnfPassword.text === password.text

                KeyNavigation.left: backButton
                KeyNavigation.right: skipButton

                onNextClicked: {
                    accepted = true
                    userModule.createUser(fullname.text, username.text, cnfPassword.text)
                }
            }
        }

        UserModule {
            id: userModule

            Component.onCompleted: {
                root.moduleName = "User Setup"
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
