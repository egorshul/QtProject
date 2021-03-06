import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page

    PageHeader {
        title: qsTr("Информация")
    }

    SilicaFlickable {
        id: flickable
        anchors.fill: page
        contentHeight: column.height
        Column {
            id: column
            width: parent.width - Theme.paddingLarge * 2
            spacing: 30
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
                top: page.top
            }

            Label {
                topPadding: Theme.paddingLarge
                width: parent.width
                text: qsTr("")
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("Задача этой игры - как можно быстрее набрать заданное десятичное число в двоичном формате.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }

            Label {
                width: parent.width
                text: qsTr("В игре доступны несколько режимов помощи:")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("1. Нет: нет вспомогательной шкалы и индикатора процесса.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("2. Счетчик: добавляет индикатор процесса, показывающий, сколько строк у вас правильных.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("3. Бар: заменяет верхнюю полосу/строку вспомогательными числами, показывая десятичное представление соответствующего бита.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("4. Оба: активирует и 2., и 3. - рекомендуется для начинающих.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
        }

        VerticalScrollDecorator {
            flickable: flickable
        }
    }
}
