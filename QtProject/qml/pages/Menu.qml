import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: menu.height

        PullDownMenu {
            MenuItem {
                text: qsTr("Информация")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Таблица рекордов")
                onClicked: pageStack.push(Qt.resolvedUrl("Board.qml"), {modes: menu.help_modes})
            }
        }

        Column {
            property var help: 0
            property var help_modes: [qsTr("Нет"), qsTr("Счетчик"), qsTr("Бар"), qsTr("Счетчик + Бар")]

            id: menu
            width: page.width
            height: page.height
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Итоговый проект")
            }

            ButtonLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rowSpacing: Theme.paddingLarge * 2

                Button {
                    text: qsTr("Помощь") + ": " + menu.help_modes[menu.help]
                    onClicked: {
                        menu.help = menu.help !== 3 ? ++menu.help : 0;
                    }
                }

                Button {
                    text: qsTr("Очень легкий")
                    ButtonLayout.newLine: true
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 2, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Легкий")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 4, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Средний")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 6, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Сложный")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 8, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Безумный")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 10, help: menu.help, modes: menu.help_modes});
                    }
                }
            }
        }
    }
}
