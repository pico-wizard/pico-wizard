// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

import org.kde.kirigami 2.9 as Kirigami

RoundButton {
    property bool accepted: false

    signal nextClicked()

    QtObject {
        id: privateProps

        property bool showSpinner: false
    }

    width: 64
    height: 64

    flat: true
    onClicked: {
        if (!accepted) {
            nextClicked()

            if (!accepted) {
                next()
            } else {
                privateProps.showSpinner = true
            }
        }
    }

    background: Rectangle {
        color: Kirigami.Theme.highlightColor
        radius: parent.width
    }

    Kirigami.Icon {
        id: nextIcon
        width: 24
        height: 24
        color: "#ffffffff"
        isMask: true

        anchors.centerIn: parent
        source: Qt.resolvedUrl("./assets/next.svg")

        states: [
            State {
                when: !privateProps.showSpinner;
                PropertyChanges {
                    target: nextIcon
                    opacity: 1.0
                }
            },
            State {
                when: privateProps.showSpinner;
                PropertyChanges {
                    target: nextIcon
                    opacity: 0.0
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                property: "opacity"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    }

    Kirigami.Icon {
        id: spinnerIcon
        width: 24
        height: 24
        color: "#ffffffff"
        isMask: true

        anchors.centerIn: parent
        source: Qt.resolvedUrl("./assets/spinner.svg")

        states: [
            State {
                when: privateProps.showSpinner;
                PropertyChanges {
                    target: spinnerIcon
                    opacity: 1.0
                }
            },
            State {
                when: !privateProps.showSpinner;
                PropertyChanges {
                    target: spinnerIcon
                    opacity: 0.0
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                property: "opacity"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: -90
            to: 270
            duration: 500
            running: true
        }
    }

    Timer {
        id: resetSpinnerTimer
        repeat: false
        interval: 500
        onTriggered: {
            accepted = false
            privateProps.showSpinner = false
        }
    }

    function next() {
        moduleLoader.nextModule()
        resetSpinnerTimer.start()
    }
    function cancel() {
        resetSpinnerTimer.start()
    }
}
