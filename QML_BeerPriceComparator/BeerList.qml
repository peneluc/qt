import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Window 2.2

Page {
    title: "Comparador de Preço de cervejas"
    property alias beerListViewModel: beerListView.model

    header:
        ToolBar {
            Label {
                text: qsTr("Lista")
                font.pixelSize: 20
                anchors.centerIn: parent
            }

            Button {
                id: getJSON
                text: qsTr("Buscar Online")
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: getJSON.down ? "#d6d6d6" : "#f6f6f6"
                    border.color: "#26282a"
                    border.width: 1
                    radius: 4
                }

                onClicked: {
                    var rs = loadBeersJson();
                }
            }
        }

    Label{
        text: "Nenhuma Cerveja cadastrada"
        anchors.centerIn: parent
        visible: !beerListView.model.count
    }

    ListView{
        id: beerListView
        model: ListModel { }
        anchors.fill: parent


        delegate: Rectangle{
            id : delegate
            width: parent.width
            height: 100

            property int _itemId : itemId
            property string _nome: nome
            property real _volume: volume
            property double _preco: preco
            property real _latitude: latitude
            property real _longitude: longitude

            Column{
                anchors{fill: parent; margins: 5 }

                Row{
                    Text {
                        id: txtID
                        text: " ID: "  + itemId
                    }
                }
                Row{
                    spacing: 2

                    Text {
                        id: txtNome
                        text: " Cerveja: "  + nome
                    }
                    Text{
                        id: txtVolume
                        text: " volume: " + volume
                    }
                    Text{
                        id: txtValor
                        text: " Valor: " + preco
                    }
                    Text{
                        id: txtLatitude
                        text: " Latitude: " + latitude
                    }
                    Text{
                        id: txtLongitude
                        text: " Longitude: " + longitude
                    }
                }

            }
        }
    }

}
