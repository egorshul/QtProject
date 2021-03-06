import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import ".."

Page {
    property int bits: 0
    property var help: 0
    property var modes: []

    id: page
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: root.height

        PullDownMenu {
            MenuItem {
                text: qsTr("Информация")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Таблица рекордов")
                onClicked: pageStack.push(Qt.resolvedUrl("Board.qml"), {modes: root.help_modes})
            }
        }

        Column {
            property int bits: page.bits
            property var help: page.help
            property var help_modes: page.modes
            property var correct: new Array(bits)
            property var matrix: new Array(Math.pow(bits + 1, 2))
            property var start_time: 0

            id: root
            width: page.width
            height: page.height
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Итоговый проект")
            }

            function nearest(number) {
                if (number % (bits + 1) === 0) {
                    return number
                } else {
                    return number - (number % (bits + 1))
                }
            }

            function check(index) {
                root.matrix[index] ^= 1;
                var near = nearest(index);
                var current_score = parseInt(info_label.text.substr(0, info_label.text.indexOf('/')))

                if (Number(root.matrix.slice(near, near + bits).join("")).toString() === (root.matrix[near + bits] >>> 0).toString(2) && timer.running) {
                    correct[near / (bits + 1) - 1] = 1;
                    info_label.text = current_score + 1 + " / " + root.bits;
                } else {
                    if (correct[near / (bits + 1) - 1] === 1 && timer.running) {
                        info_label.text = current_score - 1 + " / " + root.bits;
                    }

                    correct[near / (bits + 1) - 1] = 0;
                }

                function getMode() {
                    switch (bits) {
                    case 2:
                        return "[Очень легкий]: ";
                    case 4:
                        return "[Легкий]: ";
                    case 6:
                        return "[Средний]: ";
                    case 8:
                        return "[Сложный]: ";
                    case 10:
                        return "[Безумный]: ";
                    default:
                        return "???";
                    }
                }

                if (correct.filter(function(i) { return i === 1 }).length === bits) {
                    if (timer.running) {
                        var end_time = (new Date()).getTime();
                        timer.running = false;
                        info_label.visible = true;
                        info_label.text = "Урааааа!";
                        time.text = (((end_time - start_time) / 1000)).toFixed(3) + " сек";
                        timer_label.text = (((end_time - start_time) / 1000)).toFixed(3) + " сек - " + qsTr("Не плохо!");
                        dataBase.createNode(getMode(), time.text);
                        timer.running = false;
                        new_game.visible = true;
                    }
                }
            }

            Grid {
                property int row: 0

                id: grid
                anchors.bottom: page.bottom
                columns: root.bits + 1
                rows: root.bits + 1
                Repeater {
                    id: repeater
                    model: Math.pow(root.bits + 1, 2)
                    delegate: Bit {
                        bits: root.bits
                        index: modelData
                        width: page.width / (root.bits + 1)
                    }
                }
            }

            Label {
                id: info_label
                text: "0 / " + root.bits
                visible: root.help === 1 || root.help === 3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: page.bottom
            }

            Label {
                id: time
                text: "-1s"
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: page.bottom
            }

            Label {
                id: timer_label
                text: "-1s"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: page.bottom
            }

            Timer {
                id: timer
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    if (root.start_time === 0)
                        root.start_time = (new Date()).getTime();
                    timer_label.text = parseInt(timer_label.text.substr(0, timer_label.text.indexOf('s'))) + 1 + "s";
                }
            }

            Button {
                id: new_game
                text: qsTr("Играть снова")
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: pageStack.replace(Qt.resolvedUrl("Game.qml"), {bits: page.bits, help: page.help, modes: page.modes})
            }
        }

        Item {
            id: dataBase
            property var db

            Component.onCompleted: {
                db = LocalStorage.openDatabaseSync("db", "1.0")
                db.transaction(function(tx) {
                    tx.executeSql("CREATE TABLE IF NOT EXISTS notes (
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            mode TEXT,
                            time TEXT)");
                });
            }

            function createNode(mode, time) {
                db.transaction(function(tx) {
                    tx.executeSql("INSERT INTO notes(mode, time) VALUES(?, ?)", [mode, time]);
                });
            }

            function retrieveRecords(isFinished, callback) {
                db.readTransaction(function(tx) {
                    var result = tx.executeSql("SELECT * FROM notes");
                    callback(result.rows);
                });
            }
        }
    }
}
