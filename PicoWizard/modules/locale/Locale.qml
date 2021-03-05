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
                        text: qsTr("Search locales")
                        color: "#888888"
                    }
                }
                color: "#222222"
                selectionColor: "#2196f3"
                selectedTextColor: "#ffffff"

                onTextChanged: {
                    localeModule.filterText = text
                }
            }

            Rectangle {
                id: localeContainer
                Layout.preferredWidth: root.width * 0.7
                Layout.fillHeight: true

                radius: 4
                border.width: 2
                border.color: "#fff0f0f0"
                color: "#fff5f5f5"

                ScrollIndicator {
                    id: localeScroll
                    width: 12
                    anchors {
                        top: localeContainer.top
                        right: localeContainer.right
                        bottom: localeContainer.bottom
                    }
                }

                ListView {
                    id: localeListView
                    anchors.fill: parent
                    anchors.margins: 8

                    spacing: 4
                    model: localeModule.model
                    clip: true
                    ScrollIndicator.vertical: localeScroll

                    delegate: Rectangle {
                        width: parent ? parent.width : 0
                        height: 40

//                        color: selected ? Material.color(Material.Blue) : "#ffffffff"

                        RowLayout {
                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                                leftMargin: 12
                            }

                            CheckBox {
                                checked: selected
                                Material.accent: Material.color(Material.Blue)
                            }

                            Label {
//                                color: selected ? "#ffffffff" : "#ff444444"

                                text: name
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var curIndex = localeModule.model.index(index, 0);

                                localeModule.model.setData(
                                    curIndex,
                                    !localeModule.model.data(curIndex, LocaleModel.Roles.SelectedRole),
                                    LocaleModel.Roles.SelectedRole
                                )
                            }
                        }
                    }
                }
            }
        }

        NextButton {
            id: nextButton

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0
            }
        }

        LocaleModule {
            id: localeModule

            Component.onCompleted: {
                root.moduleName = localeModule.moduleName()
                root.moduleIcon = localeModule.dir() + "/assets/locale.svg"
            }
        }
    }
}
