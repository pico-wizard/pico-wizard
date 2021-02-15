// SPDX-FileCopyrightText: 2021 Anupam Basak <anupam.basak27@gmail.com>
//
// SPDX-License-Identifier: MIT

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

import org.kde.kirigami 2.7 as Kirigami

import PicoWizard 1.0

Module {
    id: root
    moduleName: simModule.moduleName()
    moduleIcon: simModule.dir() + "/assets/sim.svg"
    moduleIconColor: "#ff999999"

    delegate: Item {
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            ComboBox {
                Layout.preferredWidth: root.width * 0.4
                model: [1, 2, 3, 4, 5]
            }
        }

        NextButton {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 16
            }
        }
    }

    SimModule {
        id: simModule
    }
}
