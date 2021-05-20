import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0
import QtQuick.LocalStorage 2.0

Page {
    property var modes: []

    id: page
    allowedOrientations: Orientation.Portrait

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium

        PageHeader {
            title: qsTr("Таблица рекордов")
        }

        ListModel {
            id: dataModel
        }
        Column {
            width: parent.width
            height: parent.height
            spacing: 30

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Отчистить"
                onClicked: {
                    dataBase.clearTable();
                    dataBase.selectRecords();
                }
            }

            SilicaListView {
                id: listview
                width: parent.width;
                height: parent.height - 20;
                model:dataModel
                delegate: Label {
                    id: label
                    width: parent.width
                    height: 70
                    text: model.mode + "   " + model.time;
                }
                Component.onCompleted:
                {
                    dataBase.selectRecords();
                }
                VerticalScrollDecorator {}
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

            function retrieveRecords(callback) {
                db.readTransaction(function(tx) {
                    var result = tx.executeSql("SELECT * FROM notes ORDER BY mode, time");
                    callback(result.rows);
                });
            }

            function selectRecords() {
                dataModel.clear();
                dataBase.retrieveRecords(function(notes){
                    for(var i = 0; i < notes.length; i++) {
                        var note = notes.item(i);
                        dataModel.append({id:note.id, mode:note.mode, time:note.time});
                    }
                });
            }

            function clearTable() {
                db.transaction(function(tx) {
                    tx.executeSql("DELETE FROM notes;")
                });
            }

        }
    }
}
