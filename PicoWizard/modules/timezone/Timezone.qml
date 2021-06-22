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
    id: root
    moduleIconColor: "#ff999999"

    delegate: Item {
        ColumnLayout {
            anchors {
                top: parent.top
                bottom: nextButton.top
                bottomMargin: 16
                horizontalCenter: parent.horizontalCenter
            }

            PlasmaComponents.TextField {
                id: searchText
                Layout.preferredWidth: root.width * 0.7
                Layout.preferredHeight: 48

                background: Rectangle {
                    anchors.fill: parent
                    color: "#f5f5f5"

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        visible: searchText.text.length <= 0
                        text: qsTr("Timezone")
                        color: "#888888"
                    }
                }
                color: "#222222"
                selectionColor: "#2196f3"
                selectedTextColor: "#ffffff"

                onTextChanged: {
                    timezoneModule.filterText = text
                }
            }

            Rectangle {
                id: tzContainer
                Layout.preferredWidth: root.width * 0.7
                Layout.fillHeight: true

                radius: 4
                border.width: 2
                border.color: "#fff0f0f0"
                color: "#fff5f5f5"

                ScrollIndicator {
                    id: tzScroll
                    width: 12
                    anchors {
                        top: tzContainer.top
                        right: tzContainer.right
                        bottom: tzContainer.bottom
                    }
                }

                ListView {
                    id: tzListView
                    anchors.fill: parent
                    anchors.margins: 8

                    spacing: 4
                    model: timezoneModule.model
                    clip: true
                    ScrollIndicator.vertical: tzScroll

                    delegate: Rectangle {
                        width: parent ? parent.width : 0
                        height: 40

                        color: ListView.isCurrentItem ? Material.color(Material.Blue) : "#ffffffff"

                        Label {
                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                                leftMargin: 12
                            }
                            color: parent.ListView.isCurrentItem ? "#ffffffff" : "#ff444444"

                            text: tz
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                tzListView.currentIndex = index
                            }
                        }
                    }
                }
            }
        }

        NextButton {
            id: nextButton
            onNextClicked: {
                accepted = true
                timezoneModule.setTimezone(tzListView.currentIndex)
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0
            }
        }

        TimezoneModule {
            id: timezoneModule

            Component.onCompleted: {
                root.moduleName = timezoneModule.moduleName()
                root.moduleIcon = timezoneModule.dir() + "/assets/timezone.svg"
            }

            property var signals: Connections {
                function onSetTimezoneSuccess() {
                    nextButton.next()
                }

                function onSetTimezoneFailed() {
                    nextButton.cancel()
                }

                function onErrorOccurred(err) {
                    console.log(`TZ ErrorOccurred : ${err}`)
                    toastManager.show(err, 2000)
                }
            }
        }
    }
}
