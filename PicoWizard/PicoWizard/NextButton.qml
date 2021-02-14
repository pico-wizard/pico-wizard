import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import org.kde.kirigami 2.7 as Kirigami

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

    Material.background: Material.color(Material.Blue, Material.Shade500)
    Material.elevation: 4

    Kirigami.Icon {
        id: nextIcon
        width: 24
        height: 24

        anchors.centerIn: parent
        source: Qt.resolvedUrl("./assets/next.svg")
        color: "#ffffffff"

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

        anchors.centerIn: parent
        source: Qt.resolvedUrl("./assets/spinner.svg")
        color: "#ffffffff"

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
