import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Page {
    title: "Cervejas"

    property alias listViewModel: listView.model

    Label {
        visible: !listView.model.count
        text: "Nenhuma cerveja registrada!"
        anchors.centerIn: parent
    }

    ListView {
        id: listView
        model: ListModel { }
        anchors.fill: parent

        delegate: Rectangle {
            id: delegate
            width: parent.width; height: 65

            property int _itemId: itemId
            property int _volume: volume
            property real _valor: valor

            MouseArea {
                anchors.fill: parent
                onPressAndHold: {
                    var callback = function() {
                        database.excluirItem(_itemId)
                        delegate.ListView.view.model.remove(index)
                        toast.show("Item removido com sucesso!")
                        callback = null
                    }
                    showdialog("Atenção!", "Tem certeza que deseja remover o item selecionado?", callback)
                }
            }

            Column {
                anchors { fill: parent; margins: 16 }

                Row {
                    spacing: 5

                    Text {
                        text: "Item: "
                        color: "#888"
                    }

                    Text {
                        text: nome
                        color: "#555"
                    }
                }

                Row {
                    spacing: 5

                    Text {
                        text: "Volume: "
                        color: "#888"
                    }

                    Text {
                        text: _volume
                        color: "#555"
                    }
                }

            }

            Row {
                spacing: 2

                Text {
                    text: "Valor: "
                    color: "#888"
                }

                Text {
                    text: "R$"
                    color: "#555"
                }

                Text {
                    text: _valor
                    color: "#555"
                }
            }

            Text {
                color: "#888"
                text: local
                font.pointSize: 8
                anchors { right: parent.right; rightMargin: 15; top: parent.top; topMargin: 4 }
            }

            Divider { }
        }
    }
}
