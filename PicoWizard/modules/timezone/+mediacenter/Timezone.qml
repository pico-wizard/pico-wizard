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
                border.width: searchFieldFocusBox.activeFocus ? 1 : 0

                KeyNavigation.down: tzContainer
                Keys.onReturnPressed: {
                    searchText.forceActiveFocus()
                }

                PlasmaComponents.TextField {
                    id: searchText
                    anchors.fill: parent
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
                border.width: 1
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

                    KeyNavigation.left: backButton
                    KeyNavigation.right: skipButton

                    onNextClicked: {
                        accepted = true
                        timezoneModule.setTimezone(tzListView.currentIndex)
                    }
                }

                Button {
                    id: skipButton
                    Layout.fillWidth: true
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3

                    KeyNavigation.left: nextButton

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
