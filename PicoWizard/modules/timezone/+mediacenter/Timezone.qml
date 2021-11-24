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
    id: root
    moduleIconColor: "#ff999999"

    delegate: Item {

        Component.onCompleted: {
            searchFieldFocusBox.forceActiveFocus()
        }

        ColumnLayout {
            anchors {
                top: parent.top
                bottom: parent.bottom
                bottomMargin: 16
                horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: searchFieldFocusBox
                Layout.preferredWidth: root.width * 0.7
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                color: "transparent"
                border.color: searchFieldFocusBox.activeFocus ? Kirigami.Theme.highlightColor : "transparent"
                border.width: searchFieldFocusBox.activeFocus ? 3 : 0

                KeyNavigation.down: tzContainer
                Keys.onReturnPressed: {
                    searchText.forceActiveFocus()
                }

                PlasmaComponents.TextField {
                    id: searchText
                    anchors.fill: parent
                    anchors.margins: 5
                    topPadding: 16
                    bottomPadding: 16
                    placeholderText: qsTr("Search Timezone")

                    onTextChanged: {
                        timezoneModule.filterText = text
                    }
                }
            }

            Rectangle {
                id: tzContainer
                Layout.preferredWidth: root.width * 0.7
                Layout.fillHeight: true

                radius: 4
                border.width: tzContainer.activeFocus ? 3 : 1
                border.color: tzContainer.activeFocus ? Kirigami.Theme.highlightColor : Qt.lighter(Kirigami.Theme.backgroundColor, 1.5)
                color: Kirigami.Theme.backgroundColor

                KeyNavigation.down: nextButton
                Keys.onReturnPressed: {
                    tzListView.forceActiveFocus()
                }

                ScrollIndicator {
                    id: tzScroll
                    width: 12
                    anchors {
                        top: tzContainer.top
                        right: tzContainer.right
                        bottom: tzContainer.bottom
                    }
                }

                Kirigami.CardsListView {
                    id: tzListView
                    anchors.fill: parent
                    anchors.margins: 8

                    spacing: 4
                    model: timezoneModule.model
                    clip: true
                    ScrollIndicator.vertical: tzScroll

                    delegate: Kirigami.BasicListItem {
                        width: parent ? parent.width : 0
                        height: 40
                        label: tz

                        Keys.onReturnPressed: {
                            clicked()
                        }

                        onClicked: {
                            tzListView.currentIndex = index
                            nextButton.forceActiveFocus()
                        }
                    }
                }
            }

            RowLayout {
                Layout.preferredWidth: root.width * 0.7
                Layout.preferredHeight: Kirigami.Units.gridUnit * 3

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    color: "transparent"
                    border.width: backButton.activeFocus ? 3 : 0
                    border.color: Kirigami.Theme.highlightColor
                    radius: 3

                    Button {
                        id: backButton
                        anchors.fill: parent
                        anchors.margins: 2
                        highlighted: backButton.activeFocus ? 1 : 0
                        KeyNavigation.right: nextButton
                        KeyNavigation.up: tzContainer

                        icon.name: "go-previous"
                        text: "Back"

                        Keys.onReturnPressed: clicked()

                        onClicked: {
                            moduleLoader.back()
                        }
                        visible: moduleLoader.hasPrevious
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    color: "transparent"
                    border.width: nextButton.activeFocus ? 3 : 0
                    border.color: Kirigami.Theme.highlightColor
                    radius: 3

                    NextButtonMediaCenter {
                        id: nextButton
                        anchors.fill: parent
                        anchors.margins: 2
                        highlighted: nextButton.activeFocus ? 1 : 0

                        KeyNavigation.left: backButton
                        KeyNavigation.right: skipButton
                        KeyNavigation.up: tzContainer

                        onNextClicked: {
                            accepted = true
                            timezoneModule.setTimezone(tzListView.currentIndex)
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    color: "transparent"
                    border.width: skipButton.activeFocus ? 3 : 0
                    border.color: Kirigami.Theme.highlightColor
                    radius: 3

                    Button {
                        id: skipButton
                        anchors.fill: parent
                        anchors.margins: 2
                        highlighted: skipButton.activeFocus ? 1 : 0

                        KeyNavigation.left: nextButton
                        KeyNavigation.up: tzContainer

                        icon.name: "go-next-skip"
                        text: "Skip"

                        visible: !hideSkip

                        Keys.onReturnPressed: clicked()

                        onClicked: {
                            moduleLoader.nextModule()
                        }
                    }
                }
            }
        }

        TimezoneModule {
            id: timezoneModule

            Component.onCompleted: {
                root.moduleName = "Timezone Setup"
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
