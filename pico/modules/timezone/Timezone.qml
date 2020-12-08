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
                Layout.preferredWidth: root.width * 0.6
                Layout.preferredHeight: 64
                placeholderText: "Timezone"

                onTextChanged: {
                    timezoneModule.filterText = text
                }
            }

            Rectangle {
                id: tzContainer
                Layout.preferredWidth: root.width * 0.6
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
                    anchors.margins: 16

                    spacing: 4
                    model: timezoneModule.model
                    clip: true
                    ScrollIndicator.vertical: tzScroll

                    delegate: Rectangle {
                        width: parent ? parent.width : 0
                        height: 60

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
                bottomMargin: 16
            }
        }

        TimezoneModule {
            id: timezoneModule

            Component.onCompleted: {
                root.moduleName = timezoneModule.moduleName()
                root.moduleIcon = timezoneModule.dir() + "/assets/timezone.svg"
            }

            onSetTimezoneSuccess: {
                nextButton.next()
            }

            onSetTimezoneFailed: {
                nextButton.cancel()
            }
        }
    }
}
